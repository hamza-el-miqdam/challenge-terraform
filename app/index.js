const AWS = require('aws-sdk');
const crypto = require('crypto');
const express = require('express');
const logger = require('morgan');

const tableName = 'books';
const PORT = process.env.PORT || 3000;

AWS.config.update({ region: 'eu-west-1' });

const dynamodbClient = new AWS.DynamoDB.DocumentClient({ apiVersion: '2012-08-10' });

const getItems = async () => {
    try {
        const params = {
            TableName: tableName
        };
        const data = await dynamodbClient.scan(params).promise()
        return data.Items
    }
    catch (err) {
        console.log(err);
    }
}

const setItem = async ({ title, author, genre }) => {

    const params = {
        Item: {
            "id": crypto.randomUUID(),
            "Title": title,
            "Author": author,
            "Genre": genre,
        },
        TableName: tableName,
        ReturnConsumedCapacity: 'TOTAL'
    };
    const data = await dynamodbClient.put(params).promise()

    return data
}

const app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.get('/', (req, res, next) => {
    res.status(200).send("Health Ok");
});

app.get('/books', async (req, res, next) => {
    try {
        const items = await getItems()

        res.type('application/json').status(200).send(items);
    }
    catch (err) {
        res.status(500).send(err.message);
        console.error(err)
    }
});

app.post('/books/set', async (req, res) => {
    try {
        const { title, author, genre } = req.body
        const error = []
        if (typeof title != 'string') {
            error.push("title")
        }
        if (typeof author != 'string') {
            error.push("author")
        }
        if (typeof genre != 'string') {
            error.push("genre")
        }

        if (error.length != 0) {
            throw Error(`Missing parrameters: ${error.join(", ")}`)
        }

        await setItem({ title, author, genre })

        res.sendStatus(200);
    }
    catch (err) {
        res.status(500).send(err.message);
        console.error(err)
    }
});


process.on('SIGINT', () => process.exit(0));
process.on('SIGTERM', () => process.exit(0));

app.listen(PORT,  (err) => {
    if (err) console.error("Error in server setup")
    console.log("Server listening on Port", PORT);
});