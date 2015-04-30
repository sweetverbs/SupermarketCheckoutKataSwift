Supermarket Checkout Kata
=========================

This is a short retrospective, covering the decisions made in writing the Supermarket Checkout kata and how they affected the final code.

Representing Prices
-------------------

The first decision made was how to represent the price of an individual product. 

My gut feeling was to model the physical items in a shopper's basket, either by having an Item superclass, or an Item protocol, which all item implementations would adhere to. This would have ensured that, e.g., any two packets of biscuits were guaranteed to have the same name and price. When I started to take this idea forward and consider the implications for the checkout, I decided that it would be more difficult to create, scan and then work with these objects than I'd ideally have liked. E.g., in order to equate two of these objects I would have needed to implement the Equatable protocol for each of my Item classes. I also felt uneasy with the idea of creating multiple instances of what would essentially have been static, unchanging classes.

I also considered representing Item as an enum, with cases for each new item, but I decided that the barrier of having to edit an existing enum, as opposed to just creating a new item, was too great.

Based on this, I tried a different approach: modelling the concept of the checkout's record of an item (the ProductRecord). This allowed me to, e.g., only create one record for "Biscuits" which would then be used as a reference as packets of biscuits were scanned at the checkout. Doing this meant that my checkout class would be required to scan strings representing the item's name, but I didn't feel that was too big a deal, as it's fairly analogous to scanning a barcode in real life.

Representing Deals
------------------

When it came to representing offers, I strongly felt that this should be handled by the record of the product itself. Since I had decided to model the record of what was sold, as opposed to the physical item, it made sense that this would also keep note of any associated discount. 

Since I had decided above that I didn't want to create a new class for each new item, I had to add a function-type property to the ProductRecord class. This property was added as an optional property, so that ProductRecords could be created without requiring a discount. This meant that my final "Cost of n items" method could call the discount rule function if it existed, or return the number of items times the individual cost if not.

As I went on, I discovered a few downsides to this representation:

* Items cannot have multiple deals. Though this was not a requirement, it seems like a realistic future extension.
* Deals cannot span different products. E.g., if we wanted to add a "meal deal" which gave customers a sandwich and a drink for a fixed price, this would not be possible.
* An item's deal cannot be replaced without creating a new ProductRecord. This one could actually be easily fixed by changing the declaration to a 'var'. It might also be wise to do the same thing with 'cost' given that the cost of an item is likely to change in reality.

These downsides would seem to suggest that the checkout should own a collection of discount rule objects, which it applies when asked for the total cost of its scanned items. However, given that both of the above points were outside the scope of the kata's requirements, I feel that the featured implementation is sufficient.


Representing the Checkout
-------------------------

Having implemented deals the way I did, totalling the cost of scanned items, and working out the savings, was actually quite easy. It was simply a case of mapping the numbers of each item scanned to their associated ProductRecord costs, and then adding them up.

The main difficulty I had with implementing the checkout was actually how to store the scanned items. My initial reaction was to have a dictionary with ProductRecords as keys and Ints counting the number of that product scanned as values, however, I realised that this would require me to implement the Hashable protocol in my ProductRecord class. I considered doing this, but couldn't work out how I might sufficiently hash the discount rule closures. My next option was to have ProductRecord inherit from NSObject, but given I had managed to keep the code purely within the confines of Swift thus far, I didn't feel that was a suitable compromise. My solution was to have two dictionaries, with the ProductRecord's name used as the key in both, to bridge the number of times the product has been scanned in, and the associated ProductRecord. This doesn't feel like an entirely clean solution but, compared to the given alternatives, feels like the best option.