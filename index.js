const express = require('express')
const app = express()
const port = 8080
const mysql = require('mysql')
const bodyParser = require('body-parser')
const { body, validationResult } = require("express-validator")
const fs = require('fs')
const date = require('date-and-time')

app.use(bodyParser.json());
// MySQL Connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'hims'
});
// Connect to MySQL
db.connect((err) => {
if (err) {
    console.error('Error connecting to MySQL: ' + err.stack);
    return;
}
console.log('Connected to MySQL as ID ' + db.threadId);
});
 

app.get('/doctor', (req, res) => {
    res.send('Hello Doctor!')
    
})

app.get('/doctor/displayDoctors', (req, res) => {
    db.query('SELECT * FROM doctors', (err, results) => {
        if (err) {
            console.error('Error executing query: ' + err.stack);
            res.status(500).send('Error fetching users');
            return;
        }
        //fetch doctor details and export in excel sheet
        var writeStream = fs.createWriteStream("export/file.xls");

        var header="Sl No"+"\t"+" First Name"+"\t"+" Last Name"+"\t"+" Age"+"\t"+"Gender"+"\t"+"Dob"+"\t"+ "Doj"+ "\t" +"Speciality" + "\t"+ "Salary" + "\n";
        writeStream.write(header);
        let i = 1;
        let textContent = header;

        results.forEach(doctor => {
            var row = i+"\t"+doctor.first_name+"\t"+doctor.last_name+"\t"+doctor.age+"\t"+doctor.gender+"\t"+date.format((new Date(doctor.dob)),'YYYY/MM/DD')+"\t"+date.format((new Date(doctor.doj)),'YYYY/MM/DD')+"\t"+doctor.speciality+"\t"+ doctor.salary+"\n";
            console.log('row data', row);
            i++;
            writeStream.write(row);
            textContent += row;
        });
        writeStream.close();
        //write file to text file
        fs.writeFile('export/file.txt', textContent, (err) => {
            if (err) {
              console.error(err);
              return;
            }
            console.log('Data written to file');
        });
        
        //response to api
        res.json(results);
    });
})

app.get('/doctor/:id', (req, res) => {
    db.query('SELECT * FROM doctors where id = ? ', [req.params.id] , (err, results) => {
        if (err) {
            console.error('Error executing query: ' + err.stack);
            res.status(500).send('Error fetching users');
            return;
        }
        res.json(results)
    })
})

app.put('/doctor/:id', [
    body("salary").notEmpty()
],
(req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() })
    }
    //update doctors
    db.query('UPDATE doctors set salary = ? where id = ? ', [req.body.salary, req.params.id] , (err, results) => {
        if (err) {
            console.error('Error executing query: ' + err.stack);
            res.status(500).send('Error fetching users');
            return;
        }
        res.status(201).send('doctor salary updated!')
    });
})

app.post('/doctor/createDoctor',[
    body("first_name").notEmpty(),
    body("last_name").notEmpty(),
    body("age").notEmpty(),
    body("gender").notEmpty(),
    body("doj").notEmpty(),
    body("dob").notEmpty(),
    body("speciality").notEmpty()
], async(req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() })
    }
    //save data into database
    const { first_name, last_name, age, gender, speciality, doj, dob, salary, status } = req.body;
    console.log(first_name, last_name, age, gender, speciality, doj, dob, salary, status);

    db.query('INSERT INTO doctors (first_name, last_name, age, gender, speciality, doj, dob, salary, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', [first_name, last_name, age, gender, speciality, doj, dob, salary, status], (err, result) => {
      if (err) {
        console.error('Error executing query: ' + err.stack)
        res.status(400).send('Error creating user')
        return;
      }
      res.status(201).send('User created successfully')
    });
    // res.send("Hello World")
})

app.delete('/doctor/:id', (req, res) => {
    db.query('DELETE FROM doctors where id = ? ', [req.params.id] , (err, results) => {
        if (err) {
            console.error('Error executing query: ' + err.stack);
            res.status(500).send('Error fetching users');
            return;
        }
        res.status(200).send('Doctor deleted successfully');
    })
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})