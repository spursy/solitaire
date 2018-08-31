module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    testnet: {
      host: "193.112.195.120",
      port: 8545,
      network_id: "*",
      from: "0x97ca99db92255de13e143e5271f9f9fb1443099d",
      gas: 4612388  // Gas
    }
  }
};