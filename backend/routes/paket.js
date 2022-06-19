//import auth
// const auth = require("../auth")
// const jwt = require("jsonwebtoken")
// const SECRET_KEY = "BelajarNodeJSItuMenyengankan"

//import library
//import express
const express = require("express")
const bodyParser = require('body-parser');


const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

//import model
const model = require('../models/index');
const paket = model.paket

const Sequelize = require('sequelize');
const Op = Sequelize.Op;

//endpoint menampilkan semua data paket, method: GET, function: findAll()
app.get("/", async (req, res) => {
    let result = await paket.findAll()
    res.json(result)
})


app.get("/:id_paket", async (req, res) => {
    let result = await paket.findOne({
        where: { id_paket: req.params.id_paket },
    })
    res.json({
        paket: result
    })

})

app.get("/byCategory/:category", async (req, res) => {
    let result = await paket.findAll({
        where: {jenis: req.params.category},
    })
    res.json(result)

})

// endpoint untuk menyimpan data paket, METHOD: POST, function: create
app.post("/", (req, res) => {
    let data = {
        jenis: req.body.jenis,
        nama_paket: req.body.nama_paket,
        harga: req.body.harga,
        image: req.body.image
    }

    paket.create(data)
        .then(result => {
            res.json({
                message: "data has been inserted"
            })
        })
        .catch(error => {
            res.json({
                message: error.message
            })
        })
})


// Search
app.post("/search", async (req, res) => {
    let find = req.body.find
    let result = await paket.findAll({
        where: {
            [Op.or]: [
                {
                    nama_paket: {
                        [Op.like]: `%${find}%`
                    }
                },
                {
                    jenis: {
                        [Op.like]: `%${find}%`
                    }
                },
                {
                    harga: {
                        [Op.like]: `%${find}%`
                    }
                }
            ]
        },
    })
    res.json({
        paket: result
    })
})


//endpoint mengupdate data paket, METHOD: PUT, function:update
app.put("/:id", (req, res) => {
    let param = {
        id_paket: req.params.id
    }
    let data = {
        jenis: req.body.jenis,
        nama_paket: req.body.nama_paket,
        harga: req.body.harga
    }
    if (req.body.image) {
        data.image = req.body.image
    }
    paket.update(data, { where: param })
        .then(result => {
            res.json({
                message: "data has been updated"
            })
        })
        .catch(error => {
            res.json({
                message: error.message
            })
        })
})

//endpoint menghapus data paket, METHOD: DELETE, function: destroy
app.delete("/:id", async (req, res) => {
    try {
        let param = { id_paket: req.params.id }
        let result = await paket.findOne({ where: param })        
        // delete data
        paket.destroy({ where: param })
            .then(result => {
                res.json({
                    message: "data has been deleted",
                })
            })
            .catch(error => {
                res.json({
                    message: error.message
                })
            })
    } catch (error) {
        res.json({
            message: error.message
        })
    }
})

module.exports = app