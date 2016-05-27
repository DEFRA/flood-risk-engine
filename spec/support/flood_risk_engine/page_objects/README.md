Page Objects
============

This folder contains page objects to aid feature testing.

Martin Fowler [describes page objects](http://martinfowler.com/bliki/PageObject.html) as follows:

> When you write tests against a web page, you need to refer to elements within that
web page in order to click links and determine what's displayed. However, if you write
tests that manipulate the HTML elements directly your tests will be brittle to changes
in the UI. A page object wraps an HTML page, or fragment, with an application-specific API,
allowing you to manipulate page elements without digging around in the HTML.

> The basic rule of thumb for a page object is that it should allow a software client to do
anything and see anything that a human can. It should also provide an interface that's easy
to program to and hides the underlying widgetry in the window. So to access a text field you
should have accessor methods that take and return a string, check boxes should use booleans,
and buttons should be represented by action oriented method names. The page object should
encapsulate the mechanics required to find and manipulate the data in the gui control itself.
A good rule of thumb is to imagine changing the concrete control - in which case the page object
interface shouldn't change.

Useful references
-----------------

https://robots.thoughtbot.com/better-acceptance-tests-with-page-objects
https://teamgaslight.com/blog/6-ways-to-remove-pain-from-feature-testing-in-ruby-on-rails
