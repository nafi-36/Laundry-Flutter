//import express
const express = require("express")
const app = express()
app.use(express.json())

//import model
const models = require("../models/index")
const transaksi = models.transaksi
const detail_transaksi = models.detail_transaksi
const paket = models.paket
const outlet = models.outlet
const member = models.member
const user = models.user

const Sequelize = require('sequelize');
const Op = Sequelize.Op;

const moment = require('moment');

//import auth
// const auth = require("../auth")
// app.use(auth)

//Endpoint untuk menampilkan semua data transaksi
// app.get("/", async (req, res) =>{
//     let result = await transaksi.findAll({
//         include: [
//             // "outlet",
//             // "member",
//             // "user",
//             {
//                 model: models.detail_transaksi,
//                 as : "detail_transaksi",
//                 include: ["paket","transaksi"]
//             }
//         ]
//     })
//     res.json(result)
// })

// app.get("/", (req,res) => {
//     transaksi.findAll()
//         .then(result => {
//             res.json({
//                 transaksi : result
//             })
//         })
//         .catch(error => {
//             res.json({
//                 message: error.message
//             })
//         })
// })

app.get("/:id_outlet", async (req, res) => {
  let params = { id_outlet: req.params.id_outlet }
  let result = await transaksi.findAll({
    where: params,
    include: [
      "member", "outlet", "user",
      {
        model: models.detail_transaksi,
        as: "detail_transaksi",
        include: ["paket"]
      }
    ],
    order: [['createdAt', 'DESC']]
  })
  res.json({
    transaksi: result
  })
})

app.get("/lunas/:id_outlet", async (req, res) => {
  let params = { id_outlet: req.params.id_outlet, dibayar: "dibayar" }
  let result = await transaksi.findAll({
    where: params,
    include: [
      "member", "outlet", "user",
      {
        model: models.detail_transaksi,
        as: "detail_transaksi",
        include: ["paket"]
      }
    ],

  })

  let sumTotal = await transaksi.sum('total', {
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
    },
  });

  let grandTotal = await transaksi.sum('grandTotal', {
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
    },
  });

  let maxDate = await transaksi.max('tgl', {
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
    },
  });

  let minDate = await transaksi.min('tgl', {
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
    },
  });

  res.json({
    transaksi: result,
    sumTotal: sumTotal,
    sumGrand: grandTotal,
    minDate: minDate,
    maxDate: maxDate
  })
})

// Search
app.post("/search/:id_outlet", async (req, res) => {
  let find = req.body.find
  let result = await transaksi.findAll({
    where: {
      id_outlet: req.params.id_outlet,
      [Op.or]: [
        {
          kode_invoice: {
            [Op.like]: `%${find}%`
          }
        },
        {
          status: {
            [Op.like]: `%${find}%`
          }
        },
        {
          dibayar: {
            [Op.like]: `%${find}%`
          }
        },
        {
          '$member.nama$': {
            [Op.like]: `%${find}%`
          }
        }
      ]
    },
    include: [
      "member", "outlet", "user",
      {
        model: models.detail_transaksi,
        as: "detail_transaksi",
        include: ["paket"]
      }
    ],
    order: [['createdAt', 'DESC']]
  })
  res.json({
    transaksi: result
  })
})

//endpoint untuk menampilkan data transaksi berdasarkan id member
app.get("/byMember/:id_member", async (req, res) => {
  let param = { id_member: req.params.id_member }
  let result = await transaksi.findAll({
    where: param,
    include: [
      "member", "outlet", "user",
      {
        model: models.detail_transaksi,
        as: "detail_transaksi",
        include: ["paket"]
      }
    ]
  })
  res.json(result)
})

//endpoint untuk menampilkan data transaksi berdasarkan id transaksi
app.get("/byTransaksi/:id_transaksi/:id_outlet", async (req, res) => {
  let param = { id_transaksi: req.params.id_transaksi, id_outlet: req.params.id_outlet }
  let result = await transaksi.findOne({
    where: param,
    include: [
      "member", "outlet", "user",
      {
        model: models.detail_transaksi,
        as: "detail_transaksi",
        include: ["paket"]
      }
    ]
  })
  res.json({
    transaksi: result
  })
})


//endpoint untuk menambahkan data transaksi baru
app.post("/", async (req, res) => {
  let current = new Date()
  let today = moment(current).format('YYYY-MM-DD');
  let now = new Date()
  let tgl = Date.now()
  let invoices = "Laund"
  now.setDate(now.getDate() + 3)
  let data = {
    id_outlet: req.body.id_outlet,
    kode_invoice: invoices + tgl,
    id_member: req.body.id_member,
    tgl: today,
    batas_waktu: now,
    tgl_bayar: req.body.tgl_bayar,
    status: req.body.status,
    dibayar: req.body.dibayar,
    id_user: req.body.id_user,
    total: req.body.total,
  }
  transaksi.create(data)
    .then(result => {
      let lastID = result.id_transaksi
      detail = req.body.detail_transaksi
      detail.forEach(element => {
        element.id_transaksi = lastID
      });
      detail_transaksi
        .bulkCreate(detail, { individualHooks: true })
        .then(result => {
          res.json({
            message: "Data has been inserted"
          })
        })
        .catch(error => {
          res.json({
            message: error.message
          })
        })
    })
    .catch(error => {
      res.json({
        message: error.message
      })
    })
})

// endpoint update data transaksi
app.put("/:id", async (req, res) => {
  let param = {
    id_transaksi: req.params.id
  }
  let current = new Date();
  let today = moment(current).format('YYYY-MM-DD');
  let data = {
    status: req.body.status
  };
  if (data.status === "diambil") {
    data.tgl_bayar = today
    data.dibayar = "dibayar"

  }
  transaksi
    .update(data, { where: param })
    .then(async (result) => {
      res.json({
        message: "Berhasil update"
      })
    })
    .catch((error) => {
      return res.json({
        message: error.message,
      });
    });
});



//Endpoint untuk menghapus data transaksi
app.delete("/:id", (req, res) => {
  let param = {
    id_transaksi: req.params.id,
  };

  //delete detail transaksi
  detail_transaksi
    .destroy({ where: param })
    .then((result) => {
      // hapus data transaksi
      transaksi
        .destroy({ where: param })
        .then((hasil) => {
          return res.json({
            message: "data has been deleted",
          });
        })
        .catch((error) => {
          return res.json({
            message: error.message,
          });
        });
    })
    .catch((error) => {
      return res.json({
        message: error.message,
      });
    });
});

app.post("/laporan/:id_outlet", async (req, res) => {

  let start = new Date(req.body.start)
  let end = new Date(req.body.end)

  // let start = req.body.start
  // let end = req.body.end
  // if (req.body.start && req.body.end) {
  let result = await transaksi.findAll({
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
      tgl: {
        [Op.between]: [
          start, end
        ]
      }
    },
    include: [
      "member", "outlet", "user",
      {
        model: models.detail_transaksi,
        as: "detail_transaksi",
        include: ["paket"]
      },

    ],

  })

  let sumTotal = await transaksi.sum('total', {
    where: {
      id_outlet: req.params.id_outlet,
      tgl: {
        [Op.between]: [
          start, end
        ]
      }
    },
  });

  let grandTotal = await transaksi.sum('grandTotal', {
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
      tgl: {
        [Op.between]: [
          start, end
        ]
      }
    },
  });

  let maxDate = await transaksi.max('tgl', {
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
    },
  });

  let minDate = await transaksi.min('tgl', {
    where: {
      id_outlet: req.params.id_outlet,
      dibayar: "dibayar",
    },
  });

  res.json({
    transaksi: result,
    sumTotal: sumTotal,
    sumGrand: grandTotal,
    maxDate: maxDate,
    minDate: minDate
  })
  // } else {
  //   let result = await transaksi.findAll({
  //     where: {
  //       id_outlet: req.params.id_outlet,
  //       dibayar: "dibayar",
  //     },
  //     include: [
  //       "member", "outlet", "user",
  //       {
  //         model: models.detail_transaksi,
  //         as: "detail_transaksi",
  //         include: ["paket"]
  //       }
  //     ],

  //   })

  //   let sumTotal = await transaksi.sum('total', {
  //     where: {
  //       id_outlet: req.params.id_outlet,
  //       dibayar: "dibayar",
  //     },
  //   });

  //   let grandTotal = await transaksi.sum('grandTotal', {
  //     where: {
  //       id_outlet: req.params.id_outlet,
  //       dibayar: "dibayar",
  //     },
  //   });

  //   let maxDate = await transaksi.max('tgl', {
  //     where: {
  //       id_outlet: req.params.id_outlet,
  //       dibayar: "dibayar",
  //     },
  //   });

  //   let minDate = await transaksi.min('tgl', {
  //     where: {
  //       id_outlet: req.params.id_outlet,
  //       dibayar: "dibayar",
  //     },
  //   });

  //   res.json({
  //     transaksi: result,
  //     sumTotal: sumTotal,
  //     sumGrand: grandTotal,
  //     maxDate: maxDate,
  //     minDate: minDate
  //   })
  // }

})

module.exports = app