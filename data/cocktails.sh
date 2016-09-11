#!/usr/bin/env node

'use strict';

var cocktails = require('./cocktails.js');
var spirits = require('./spirits.js');

var output = [];

for (var id in cocktails) {
    if (!id) continue;

    var data = cocktails[id];
    var cocktail = {};

    cocktail.id = id;
    cocktail.name = data.name;

    var keywords = data.keywords || [];
    keywords.push(data.name);

    var ingredients = [];
    var totalVolume = 0;
    var alcoholVolume = 0;
    var alcoholPercentage = 0;

    for (var ingredient in data.ingredients) {
        var amount = data.ingredients[ingredient];

        if (amount === '') {
            keywords.push(ingredient);
            ingredients.push(ingredient);
        } else if (typeof amount === 'string') {
            keywords.push(ingredient);
            ingredients.push(amount + ' of ' + ingredient);
        } else if (typeof amount == 'number') {
            var spirit = spirits[ingredient];
            keywords.push(spirit.name);
            ingredients.push(amount/10 + ' cl ' + spirit.name);
            totalVolume += amount;
            alcoholVolume += (amount * spirit.alcoholPercentage / 100);
        }
    }

    cocktail.keywords = keywords;
    cocktail.ingredients = ingredients.join('\n');
    cocktail.searchDescription = ingredients.join(', ');
    cocktail.totalVolume = totalVolume + ' ml';
    cocktail.alcoholVolume = Math.round(alcoholVolume) + ' ml';
    cocktail.alcoholPercentage = Math.round(alcoholVolume * 100 / totalVolume) + '%';

    output.push(cocktail);
}

console.log(JSON.stringify(output));
