What's New in WCAG 2.2?

## Whats a WCAG? What you on about?

The WCAG (Web Content Accessibility Guidelines) is the guide for designing and building accessible applications. It has a number of success criteria over a number of categories and in 2023, there really is not much of an excuse to ignore these guidelines not just because it is the right thing to do but because a design that is accessible also is one that is very usable for *everyone*. Most people would rather spend their cognitive capacity on thinking of kittens and food rather than trying to navigate their way through an application no matter how beautiful and cool it looks.

 As always its important to bear in mind that they are guidelines, not simply a set of checkboxes to hit, thinking through the lens of accessibility is what counts.  There is a system of A, AA, AAA to denote the level of accessibility reached. My shorthand for this is as follows:

`A - You have not made things unusable for people with accessibility needs. But you can do better.`

`AA - You have done a decent job in making this a good experience, can you do better without huge effort though?`

`AAA - This is the gold standard, well done. Now see if your users with accessibility needs agree before you get too smug.`


While AA is a reasonable standard to hit in general, if you work on a governmental, utility or banking app, I would *strongly* argue for greater levels of accessibility since access to those services is pretty much mandatory for all abilities in the modern age.

The WCAG is freely available to read and follow so at least be aware of it though I admit it is not the most exciting of reads. So recently WCAG moved to version 2.2 in October 2023, so I was curious to see what new and exciting things this means for accessibility standards

## So whats in 2.2? Is it a big deal?

... *drumroll* ... not really. There are 9 new success criteria introduced in this release and, in my opinion, they fall under the category of **'Well, yes obviously it should do that....'**. However, having it officially in the WCAG is great for those of us that who have had to advocate pretty strongly for doing so before it was codified.

## 2.4.11/12 - Focus Not Obscured (AA/AAA)

> 2.4.11 - Ensure when an item gets keyboard focus, it is at least *partially* visible.

> 2.4.12 - Ensure when an item gets keyboard focus, it is *fully* visible.


Keyboard focus is one of the pillars of accessibility access to a web app. If a user cannot use a mouse/finger then navigating via a keyboard matters. Hit tab a few times and you'll see what I mean. Having the 'focus ring' is essential in letting a user know where they are on the site, if it is hidden, the user has no idea where they are. Keep it visible.

This one is quite commonly an issue simply because all the banners and pop-overs modern web sites have. If a site has a cookie prompt, newsletter sign up, or something like that, more often than not keyboard focus tends to suffer. While things have gotten a lot better recently (hello Dialog element) any time a banner/pop-over is introduced my accessibility-sense tingles. Be sure it tingles you too.


## 2.4.13 Focus Appearance (AAA)

> 2.4.13 - Use a focus indicator of sufficient size and contrast.

That focus ring I mentioned earlier? It might look cool if you made it a thin wispy off-white outline on your cool button but that really screws over people who actually need to see it. Make sure it is clearly visible. The WCAG goes on to say that it should be 2pm thick and with a contrast ratio of at least 3:1 between the pixels in the focused and unfocused states. I try to not get too much into the maths when thinking about accessibility, it should be clear and obvious, do that.

One common gotcha here is that you might make a lovely clear blue focus indicator which is fine 99% of the time and thus it gets forgotten about... At some point someone introduces a blue button and.... suddenly that focus ring isn't as visible as you thought it was! In a nutshell, this Success Criteria isn't hard to hit but watch out for edge cases that need ot be handled in a different way.

## 2.5.7 Dragging Movements (AA)

> For any action that involves dragging, provide a simple pointer alternative.

The WCAG would point out this is for the user that has a hand tremor and thus is unable to drag and drop. I would add that sometimes (e.g. on a phone screen) it is bloody annoying trying to drag and drop things into your UI. I know how cool your drop and drop looks and feels on your 32inch 4k screen and fancy mouse, but for others it is annoying at best, inaccessible at worst. Try using buttons to allow an alternative to drag and drag, your users will thank you.

## 2.5.8 Target Size (Minimum) (AA)

> Ensure targets meet a minimum size or have sufficient spacing around them.

This has happened to everyone I can guarantee it, especially on a mobile device. You have a bunch of icons, you tap on one and no, you actually hit another one because your finger is far bigger than the icon you were going for! Everyone is upset by this, not just those who might be impaired by pointing devices. Let your buttons breathe people, you you need to menu them away then do so, clutter is annoying for everyone. And yes I have been guilty of squeezing 'just one more icon' into a space that really shouldn't take any more. It happens but lets do better!


## 3.2.6 Consistent Help (A)

> Put help in the same place when it is on multiple pages.

I am of the generation that stubbornly refuses to click on help in any circumstance. I am also not a good role model. For others, a help option on an app is a first point of call to know what to do. It is fairly obvious but if you have a help functionality, make sure it is in a consistent place on the page to avoid confusing people. This is also just good design in general however, keeping things in a consistent place makes it easier to understand and fly through your lovingly crafted user journeys.

A gotcha here is the aforementioned banners and pop-overs, it does no good to have the help function in the same place but occasionally it gets hidden by other elements. 

## 3.3.7 Redundant Entry (A)

> Don't ask for the same information twice in the same session.

The WCAG will say that this helps those with cognitive disabilities who have difficulty remembering what they entered before. I would add, it bloody annoying to keep on providing info I entered before. I don't think this one warrants much discussion as if you are not trying to make your input processes as frictionless as possible for everyone then we probably need to chat about more basic things than WCAG.


## 3.3.8/9 Accessible Authentication (Minimum/Enhanced) (AA/ AAA)

> 3.3.8 - Don’t make people solve, recall, or transcribe something to log in. (AA)

> 3.3.9 - Don’t make people recognize objects or user-supplied images and media to login. (AAA)

Oh, now I have saved the best till last. I love it when one important principle (accessibility) is rubbing shoulders with another (security), so now you have decide if you want a secure app or an accessible app. Pick one.... Ok, ok, it isn't actually so bad, the key things to bear in mind here for are:

- Allow password managers and autocomplete to work to reduce memory need
- Allow copy and paste to reduce cognitive burden

If you are going to have a cognitive function test (i.e. click all the 'motorcycles' captcha things) then:

- Allow an alternative authentication method that avoids a reliance on cognitive function (easier)
- Support is provided to assist the user in completing the cognitive function test (more risky)

Since most people reading this are not coding up their own captcha tooling this has already been addressed for the most part by providers. But certainly its worth being mindful of this as captchas continue to be more sophistated/harder to do.

# Conclusion

I stand by my original view that these success criteria should be obvious to those of us who care about a great UX in general. But having it in the WCAG allows us to make the case for these things far more easily when dealing with people who cannot conceive of things existing outside of checkboxes and metrics... you know you have met those people before.

The true hotness to get excited about is version 3.0 which is still very much a work in progress. If you are interested in the future of accessibility, or if you got bones to pick about the WCAG then why not [get involved](https://www.w3.org/WAI/about/participating/#participating-in-guidelines-and-groups) ? 





 











