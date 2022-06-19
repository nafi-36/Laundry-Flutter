//import auth
const auth = require("../auth")
const jwt = require("jsonwebtoken")
const SECRET_KEY = "BelajarNodeJSItuMenyengankan"

//import library
const express = require('express');
const bodyParser = require('body-parser');
const md5 = require('md5');

//implementasi library
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

//import model
const model = require('../models/index');
const outlet = model.outlet

const Sequelize = require('sequelize');
const Op = Sequelize.Op;

//endpoint menampilkan semua data outlet, method: GET, function: findAll()
app.get("/", (req,res) => {
    outlet.findAll()
        .then(result => {
            res.json(result)
        })
        .catch(error => {
             res.json({
                message: error.message
            })
        })
})

//menampilkan data outlet berdasarkan id
app.get("/:id_outlet", (req, res) =>{
    outlet.findOne({ where: {id_outlet: req.params.id_outlet}})
    .then(result => {
        res.json(result)
    })
    .catch(error => {
        res.json({
            message: error.message
        })
    })
})

//endpoint untuk menyimpan data outlet, METHOD: POST, function: create
app.post("/", (req,res) => {
    let data = {
        nama_outlet : req.body.nama_outlet,
        alamat : req.body.alamat,
        tlp : req.body.tlp
    }

    outlet.create(data)
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

app.post("/search/search", async (req, res) =>{
    let find = req.body.find
    let result =  await outlet.findAll({
        where: {
            [Op.or]:[
                {nama_outlet: {
                    [Op.like]: `%${find}%`
                }},
                {alamat: {
                    [Op.like]: `%${find}%`
                }},
                {tlp: {
                    [Op.like]: `%${find}%`
                }},
                {id_outlet: {
                    [Op.like]: `%${find}%`
                }},
            ]
        }
    })
    res.json({
        outlet: result
    })
})

//endpoint mengupdate data outlet, METHOD: PUT, function:update
app.put("/:id", (req,res) => {
    let param = {
        id_outlet : req.params.id
    }
    let data = {
        nama_outlet : req.body.nama_outlet,
        alamat : req.body.alamat,
        tlp : req.body.tlp
    }
    outlet.update(data, {where: param})
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

//endpoint menghapus data outlet, METHOD: DELETE, function: destroy
app.delete("/:id", (req,res) => {
    let param = {
        id_outlet : req.params.id
    }
    outlet.destroy({where: param})
        .then(result => {
            res.json({
                message: "data has been deleted"
            })
        })
        .catch(error => {
            res.json({
                message: error.message
            })
        })
})

module.exports = app