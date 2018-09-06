const abi_path = require("../../build/contracts/SolitaireUpgrate.json");
const fs = require('fs');
const router = require('koa-router')({
  prefix: '/contract'
})

router.get('/solitaire', async (ctx, next) => {
  console.log("i ni ni i ni n i i");
  
  let file_data = abi_path;
  ctx.body = file_data;
})

module.exports = router
