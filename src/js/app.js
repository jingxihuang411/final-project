App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    $.getJSON('../videos.json', function(data) {
      var row = $('#row');
      var template = $('#template');

      for (i = 0; i < data.length; i ++) {
        template.find('.panel-title').text(data[i].name);
        template.find('img').attr('src', data[i].picture);
        template.find('.video-name').text(data[i].name);
        template.find('.video-price').text(data[i].price);
        template.find('.btn-purchase').attr('data-id', data[i].id);

        row.append(template.html());
      }
    });

    return App.initWeb3();
  },

  initWeb3: function() {
        // Is there is an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fallback to the truffle development environment
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:9545');
    }
    web3 = new Web3(App.web3Provider);

    return App.initContract();
  },

  initContract: function() {
      $.getJSON('Purchase.json', function(data) {
    // Get the necessary contract artifact file and instantiate it with truffle-contract
    App.contracts.Purchase = TruffleContract(data);

    // Set the provider for our contract
    App.contracts.Purchase.setProvider(App.web3Provider);

    // Use our contract to retrieve and mark the purchase
    return App.markVideo();
  });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-purchase', App.buyVideo);
  },

  markVideo: function(buyers, account) {
    var purchaseInstance;

    App.contracts.Purchase.deployed().then(function(instance) {
      purchaseInstance = instance;

      return purchaseInstance.getBuyers.call();
    }).then(function(buyers) {
      for (i = 0; i < buyers.length; i++) {
        if (buyers[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-video').eq(i).find('button').text('Success').attr('disabled', true);
        }
      }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  buyVideo: function(event) {
    event.preventDefault();

    var videoId = parseInt($(event.target).data('id'));

    var purchaseInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Purchase.deployed().then(function(instance) {
        purchaseInstance = instance;

        // Execute adopt as a transaction by sending account
        return purchaseInstance.buy(videoId, {from: account});
      }).then(function(result) {
        return App.markVideo();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
