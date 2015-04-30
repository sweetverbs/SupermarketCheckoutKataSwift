Supermarket Checkout Kata
=========================

This is a short retrospective, covering the decisions made in writing the Supermarket Checkout kata and how the affected the final code.

Representing Prices
-------------------

The first decision made was how to represent the price of an individual item. My initial gut feeling was to model the physical item in a shopper's basket, either by having an Item superclass, or an Item protocol, which all item implementations would adhere to. This would have ensured that, e.g., any two packets of biscuits were guaranteed to have the same name and price. When I started to take this idea forward, and consider the implications for the checkout I decided that it would be more difficult to create, scan and then work with these objects than I'd ideally have liked. E.g., in order to equate two of these objects I would have needed to implement the Equatable protocol for each of my Item classes. I also felt uneasy with the idea of creating multiple instances of what would essentially have been static, unchanging objects.

Based on this, I tried a different approach: modelling the concept of the checkout's record of an item. This allowed me to, e.g., only create one record for "Biscuits" which would then be used as a reference as packets of biscuits were scanned at the checkout. Doing this meant that my checkout class would be required to scan strings representing the item's name, but I didn't feel that was too big a deal, as it's fairly analogous to scanning a barcode in real life.

Representing Deals
------------------

