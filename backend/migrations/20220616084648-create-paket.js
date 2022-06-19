'use strict';
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('paket', {
      id_paket: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      jenis: {
        type: Sequelize.ENUM('kilo', 'bed_cover', 'blanket', 'tshirt', 'others')
      },
      nama_paket: {
        type: Sequelize.STRING
      },
      harga: {
        type: Sequelize.INTEGER
      },
      image: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('paket');
  }
};