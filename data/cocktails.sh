#!/usr/bin/env node

'use strict';

var cocktails = require('./cocktails.js');
var spirits = require('./spirits.js');

var output = [];
var not_found_spirits = new Set();


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
    var abv = 0;

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

            if (!spirit) {
                not_found_spirits.add(ingredient);
                continue;
            }

            keywords.push(spirit.name);
            ingredients.push(amount/10 + ' cl ' + spirit.name);
            totalVolume += amount;
            alcoholVolume += (amount * spirit.abv / 100);
        }
    }

    cocktail.keywords = keywords;
    cocktail.ingredients = ingredients.join('\n');
    cocktail.searchDescription = ingredients.join(', ');
    cocktail.totalVolume = totalVolume + ' ml';
    cocktail.alcoholVolume = Math.round(alcoholVolume) + ' ml';
    cocktail.abv = Math.round(alcoholVolume * 100 / totalVolume) + '%';

    output.push(cocktail);
}

if (not_found_spirits.size > 0) {
    console.error('Spirits not found:');
    console.error([...not_found_spirits].sort().join('\n'));
}

console.log(JSON.stringify(output));
