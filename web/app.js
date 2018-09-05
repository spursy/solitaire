App = {
    web3Provider: null,
    contracts: {},

    init: function() {
        if (typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider;
          } else {
            App.web3Provider = new Web3.providers.HttpProvider('http://193.112.195.120:8545');
          }
          web3 = new Web3(App.web3Provider);
      
          return this.initContract();
    },
    initContract: function() {
        // 加载Adoption.json，保存了Adoption的ABI（接口说明）信息及部署后的网络(地址)信息，它在编译合约的时候生成ABI，在部署的时候追加网络信息
        $.getJSON('SolitaireUpgrate.json', function(data) {
          var SolitaireArtifact = data;
          App.contracts.Solitaire = TruffleContract(SolitaireArtifact);
          // Set the provider for our contract
          App.contracts.Solitaire.setProvider(App.web3Provider);
        });
      },
    getContractBalance: function() {
        App.contracts.Solitaire.deployed().then(function(instance) {
          var solitaireInstance = instance;
          // 调用合约的getRandomNumArray(), 用call读取信息不用消耗gas
          return solitaireInstance.GetBalance.call();
        }).then(function(balance) {
            var ret = parseFloat(balance)/ Math.pow(10, 18);
            $('#contractbalance').val(ret + " eth");
        }).catch(function(err) {
          console.log(err.message);
        });
    },
    getAllKeys: function() {
        App.contracts.Solitaire.deployed().then(function(instance) {
          var solitaireInstance = instance;
          // 调用合约的getRandomNumArray(), 用call读取信息不用消耗gas
          return solitaireInstance.getRandomNumArray.call();
        }).then(function(randomNumArray) {
            $('#allkeys').val(randomNumArray);
        }).catch(function(err) {
          console.log(err.message);
        });
    },
    byeKey: function() {
        event.preventDefault();

        // 获取用户账号
        web3.eth.getAccounts(function(error, accounts) {
            if (error) {
                console.log(error);
            }
            var account = accounts[0];
            App.contracts.Solitaire.deployed().then(function(instance) {
                return instance.deposit({ value: web3.toWei(0.1, "ether")});
            }).then(function(result) {
                $('#mykey').val(result.tx);
            }).catch(function(err) {
                console.log(err.message);
            });
        });
    }
}

$(function() {
    $(function() {
        App.init();
    });
});