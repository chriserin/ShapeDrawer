var Inventory = Backbone.Model.extend({
  defaults: {
    cat: 3,
    dog: 5
  }
});

var ExtendedInventory = Inventory.extend({
});

ExtendedInventory.defaults = {}
_.extend(ExtendedInventory.defaults, ExtendedInventory.prototype.defaults, {rabbit: 25});

var i = new Inventory();
var ei = new ExtendedInventory();
