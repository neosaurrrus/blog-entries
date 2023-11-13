#  10 Things I Learnt About Accessibility on UK News Sites

I recently performed a brief analysis of accessibility of UK News sites, for two reasons:

1. Digital News Media is really important in allowing people to take part in society, democracy and stay connected in a ever-complicating world. I was curious if there would a real impact for those who rely on accessibility features.

2. I also wanted to improve my knowledge to let accessible design become my natural thought process so I can make strides on that in 2021.

Combining my two interests, I decided to take a slice of UK News sites and see how they approach accessibility in order to grow my own thinking. The sites I chose are:

- BBC News
- The Guardian
- The Daily Mail
- The Telegraph
- The Mirror
- The Times
- The Sun

Now a bunch of what I am going to say is very much opinionated and from the perspective of a regular Joe but hey, that's the point of a blog. For example, when I say something was not possible, that means that I couldn't figure it out. I might not be the sharpest of internet users out there but honestly, that's who is using your sites!


## 1. There is more done right than done wrong.

It's easy to criticize, as I am about to do but its important to say that overall they have done a good job, covering many of the basics to a point they don't get mentioned. But of course that just means where they drop the ball becomes even more glaring. 

Overall the BBC handles accessibility in the most effective way but to all the developers I'd say *great work, but try to learn from each other, if you took the best accessibility practices from each site you'd be perfect!*


## 2. Cookie Prompt Pain

You know the fun of cookie prompts news sites or not. One of the first things a keyboard-only user might have to do is try and find a way to get rid of it. So lets make that as painless as possible.

- **Good**: Have your cookie prompt at the top of the screen and the first thing to focus on. (BBC). 

![BBC Cookie](https://github.com/neosaurrrus/blog-entries/blob/master/pics/61/bbc.png?raw=true)

- **Hmmm...**: Sticking the cookie prompt on the bottom can be a bit more confusing for tab logic, especially when you tab past it into the main content that is obscured (Mirror)
- **Not Great**: Now allowing the cookie prompt to be focusable at all. And also have a video popup you can focus on while you are at it. (Mail Online)


## 3. Please take my accessibility user money!

Some news sites need people to pay for its content and there is nothing wrong with that. Subscription prompts tend to one of the first things we see and would be a chance to show all users the site is usable for them. So I was a little suprised to find that subscription prompts are generally less friendly than the content behind them! This is money left on the table, when the content itself is often fine in that regard. 

- **OK:** Redirect the user to a subscription page with big clear elements explaining the options (The Times... though the tab order here could be improved)
- ***Not Great:** Ask for support with a popup in the footer, but don't allow it to be focusable (The Guardian)
- **Really Not Great:** Use a subscription popup over content which is not focusable or screen readable and obscures the cookie prompt which means you have no idea where focus has gone. (The Telegraph)

![Telegraph subscription](https://github.com/neosaurrrus/blog-entries/blob/master/pics/61/telegraph.png?raw=true)

## 4. Tab Order Vs Cool Layouts

Its important for news sites to have a visually compelling layout, much like thier physical versions, I get that. However, while a mouse pointer can follow wherever a user wants, it can be disorienting when the tab order does not follow what makes sense. This is such an easy thing to test but did throw up some odd results.

- **Good:** Small elements, that follow a logical pattern. Allowing a keyboard user can follow without thinking too hard (The BBC)
- ***Okish:** Occasional long elements, causing the tab focus to jump large distances and giving keyboard users the chance to play "hide and seek" with the focus highlight (The Guardian)
- **Not Great:** Letting your tab focus follow a course no regular pair of eyeballs would. Occassionally vanishing somewhere for a few tabs before returning  (The Times)
- **Also Not Great:** Have a side bar you can see but cannot focus on till you have reacched the bottom of a very long main column (The Mail)

## 5. Alt tags for Images, sometimes silence is golder

It's great if there is a description to your images, certainly it is something that accessibility tests flag up easily. However, that doesn't mean that any text is better than no text.

- **Good:** Provide a short helpful description of what is found in the picture (BBC News)
- ***OK, fair enough... :** Don't provide a description, and just let the screen reader skip over it. (The Guardian)
- **Really Not Great:** Set the alt text to be a copy of the headline text it is next to, making screen readers effectively say the same thing twice. Annoying no matter how cute the story is.(The Sun, The Times, The Mail)

![Mail Seal](https://github.com/neosaurrrus/blog-entries/blob/master/pics/61/mail.png?raw=true)


## 6. Highlighting Interactive Elements highlights plenty of differences.

Without moving a mouse, can you see what bits of the page would do something if you clicked/tapped on it? What about if you moved the mouse over it? And what if you tabbed onto it? It is clear then?

The answers to those questions were so variable across news sites and quite subjective. More research is required but I personally found that a combination of colour and underlining provided the clearest experience. 

Mre tangible issues stem from elements that dont appear to be interactive that actually are either due to formatting matching non interactive areas.

- **Good:** Use of both colour and underlining when interactive element is focused (The BBC)
- ***Hmmm... :** Make the background a similar colour to the tab focus effectively making the element not highlight when focused. (The Guardian)

![Guardian cookies](https://github.com/neosaurrrus/blog-entries/blob/master/pics/61/guardian.png?raw=true)

- **Really Not Great:** No colour or text formatting when focused or hovered over (The Mirror)


## 7. Your 3rd party content does matter

Its understandable that news sites use advertisements and sponsored content to keep the money coming in. However while the main site can be made accessible, 3rd party content also needs to be held to the same standard as it effects the user's experience just the same as the rest of the content. 

I am not sure why advertisments wouldn't want to do something snappy for folks using screen readers but it doesn't appear to be the case in test.


- **Good:**  Allowing a screen reader to recongnise an ad, state that is an ad and move on. (The Mirror)
- ***Hmmm... :** Make the screen reader reconcognise ad content as simply web content making it confusing what it is exactly (The Sun)
- **Really Not Great:** Have sponsored content that makes no consessions to screen readers and makes them read out ID numbers and such. (The Times) 


## 8. A site can be experienced in different ways, screen reading tends to be where most issues lay.

Following on from #4. There is acrtually three journes through a site. 

1. Your eyes as you look at whats there. Studies have shown it is isnt just left-to-right up-to-down. Its interesting seeing how different sites use this to thier advantage, but this can open up challenges for the other journies.

2. Tabbing through content. Typically this will go along the navigation before following the article sequentially. Generally this is logical on sites, by which I mean it follows what we see fairly well.

3. Being guided through it by a screen reader. This is one that most often that exhibited strange behaviour and most unlike the visual experience. I am sure part of this is my lack of familarity with screen readers but I definatey recognised things that did not quite make sense. Going through a site with a screen reader does take a relativey long time, so its important to be respectful of the users time.

 **Good:** Providing 'Skip to content' or 'Jump to navigation' functionality to allow a little agency in the tab and screen reader journey.(The Telegraph, The Sun)
- ***Hmmm... :** Providing multiple links in an element adding additional complexity to screen readers and tab focusing.(The Mail)
- **Really Not Great:** Having visibly collasped menus but making screen readers read through each option anyhow. (The Times)


## 9. Lighthouse shines a helpful light, but plenty of shadows remain.

I think alot of people's plan of action for accessibility is to use Chrome's Lighthouse make the numbers go higher. When its high, job done right? Not really, most of the sites had scores in the 80s but still had issues. Conversely the BBC News site, which was perhaps the best all-round actually had the worst lighthouse score of the sites I tested.

As mentioned in #5, meeting the criteria isnt as important as that criteria providing a net positive for accessibilty. It also does not appear to give much weighting to the frequency of a particular issue. Having a lots of different issues happen on one or two elements, is arguably better than a one consistent issue that occurs everywhere. I do wonder if doggedly chasing a perfect Lighthouse score incentives a few bad practices along the way.

It is a good guide but to build for accessibility will involve getting more familiar with the [WCAG](https://www.w3.org/TR/WCAG21/) to really take the details to heart.


## 10. There is much more to look at! 

My analysis was only scratching the surface of what makes a web site accessible. For a first look it has some value but there are more areas that I would have loved to gone into. 

- Alignment to WCAG2.1 and the upcoming WCAG2.2 for a more comprehensive analysis
- Looking at the different pages found on each site.
- Mobile users and devices beyond the standard desktop.
- Behaviour across different browsers, I noticed some issues in this regard but want to do a proper job on this.
- Involving actual users of common accessibility features. (I am sure this would be a good Fiverr type service)


## Wrap up, my full results and secret shame.

I put my findings in more detail at [newsa11y](http://newsa11y.com). Which, embarrassingly, needs alot more accessibility work itself. It was intended as a quick MVP to get something going. I hope to do the exercise again next year to perform a proper, deeper, clearer and yes, accessible, analysis of the state of UK News media when it comes to accessibility, feel free to get in touch if this is something you'd love to help out with.