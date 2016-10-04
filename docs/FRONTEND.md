# ManCrates CSS Guidelines

## Absolute Basics

Before you start doing any CSS you must be a master of the layout. We
highly recommend you take a look at http://learnlayout.com/ to refresh
your memory. Even if you have done it for a while there might be things
in that list you have forgotten.

These include:

* Display: inline, block, none, inline-block, flex
* Margin: auto and max-width
* The box model
* box-sizing
* Position
* Float: and why you use it.
* Clear: and when you use it.
* Media Queries
* Column properties
* Flex Box (https://css-tricks.com/snippets/css/a-guide-to-flexbox/)


## Background
There are many many standardized ways of styling websites including

* [smacss](https://smacss.com/)
* [oocss](https://github.com/stubbornella/oocss/wiki)
* [acss](http://acss.io/)
* [bem](https://en.bem.info/methodology/key-concepts/)

All have pros and cons. At ManCrates we style our apps with a simplified
version of smacss. What follows is inspired by the original smacss but
is markedly different so read this over the original guide whenever
possible

## ManCrates SMACSS : Core

## Categorization of styles

At the very core of SMACSS is categorization. By categorizing CSS
rules, we begin to see patterns and can define better practices
around each of these patterns.

There are three types of categories:

* Base - For ManCrates this boostrap
* Layout - ManCrates also simply uses the bootstrap grid system
* Component - Almost all your time will be spent here

Note: The original smacss rules included themes and states. We don't
use either.

## Naming Rules

Its very very simple. We name our components just like bootstrap
components with lowercase letters and dashes. We only ever use classes
and no IDs.


## Component Rules

A component is anything that isn't base styles and is the category of
CSS that you will write most often. Examples include the navigation
bars, carousels, dialogs and widgets and so on. This is the meat
of the page. Modules sit inside Bootstrap grid layout. Components can
sometimes sit within other Components, too. Each Component should be
designed to exist standalone. In doing so, the page will be more
flexible. If done right, Components can easily be moved to
different parts of the layout without breaking.

When defining the rule set for a component, *avoid using IDs and
element selectors, sticking only to class names*. A component will
likely contain a number of elements and there is likely to be a
desire to use descendent or child selectors to target those elements.

**Bad Example**

```html
<style>

/* The Folder Module */
.fld > span {
    padding-left: 20px;
    background: url(icon.png);
}

</style>

<div class="fld">
    <span>Folder Name</span>
    <span>(32 items)</span>
</div>

```


**Good Example**

```html
<style>

/* The Folder Module */

.fld-name {
    padding-left: 20px;
    background: url(icon.png);
}

</style>

<div class="fld">
    <span class="fld-name">Folder Name</span>
    <span class="fld-items">(32 items)</span>
</div>

```

By adding the classes to the elements, we have increased the semantics
of what those elements mean and removed any ambiguity when it
comes to styling them.


## Subclassing Components

Instead of adding `!important` or increasing levels of specificity to
override component styles in different situations you should subclass
instead. This is precisely what Bootstrap does for most of its
components as well.

A concrete example of subclassing in Bootstrap can be found with their
labels component: http://getbootstrap.com/components/#available-variations.

Designing a subclass is as simple as using the components name
(ex `label`) and adding a dash and a suffix to create a subclass
(`-success`, creating `label-success`)

Usually you create your component with a base set of styles and override
just what you need for the subclass (much like Object Oriented
Programming).


**Bad Example**

```html
<style>

// From base styles
banner .alert{
  width: 25%;
  background-color: #00ff00;
}

// A component called alert
alert {
  width: 100% !important;
}

</style>

<div class='banner'>
  <div class='alert'>It worked</div>
</div>

```

The problem with using parent selectors is that you can run into
specificity  issues that require adding even more selectors to
battle against it or to quickly fall back to using !important.

**Good Example**

```html
<style>
// From base styles
.alert{
  width: 25%;
  background-color: #00ff00;
}

// A component called alert
alert-success {
  width: 100% ;
}

</style>

<div class='banner'>
  <div class='alert alert-success'>It worked</div>
</div>

```

With sub-classing the component, both the base component and the
sub-component class names get applied to the HTML element. This results
in few specificity problems and reduces the need to use `!important`.


## Media Queries

We have a set of media queries prebuilt for you using SCSS mixins so
you don't have to guess or repeat the declaration over and over again.


Ordering them is important and they should always be ordered like so:

* mobile-tablet
* mobile
* tablet-desktop
* tablet
* desktop

You can use them like so:

```css
  @include media(mobile) {
    ...
  }
```


We prefer to repeat media queries and keep a set of them near each
set of component selectors/rules.

```css
 // -- Awesome Gifts Hero Section --
  .awesome-gifts.hero-section {
    background-size: cover;
    border: none;
    height: inherit;
  }

  @include media(mobile) {
    .awesome-gifts.hero-section {
      height: inherit;
      padding: 15px;
    }
  }

  @include media(tablet-desktop) {
    .awesome-gifts.hero-section {
      padding: 40px 0;
      height: 580px;
    }
  }
```

## Mobile First
