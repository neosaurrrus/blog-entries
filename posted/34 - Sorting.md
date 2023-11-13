# Classic Sorting methods

When I think of computer science, I typically think of people arguing about how to sort things using methods with bizarre names. Since I lack a classic comp sci background I decided to take some time out to learn about sorting algorithms.

The limit of my knowledge prior to this is the Array.sort method you find in JAvascript but since different sorting methods take different times depending on the data I figure its useful know beyond just having arguments with my Comp Sci friends.

For the same of simplicity I will just talk about an array of numbers we want to sort in an ascending order.

## Selection Sort

Let's start with the easy one. At least to explain.

1. Selection Sort loops through the whole array
2. It marks the lowest one it finds as it goes through.
3. Once it reaches the end, the smallest element it found is moved to the front of the array by swapping it with the first element.
4. It then repeats #1 #2 #3, starting from the 2nd point in the array, tracking the start of the unsorted part basically.
5. And so on till the unsorted part of the array is effectively the end of the array.

Its not very effecient but its got given a name so here we are. `Selection sort - Don't do it` probably should be its tagline. Unless you really are limited by the amount of swaps you can do at each time.

## Bubble Sort

The sorting algorithm with the cutest name. It aint the best, but its more interesting than selection sort.

The main idea is that Bubble Sort compares pairs as it loops through the array, if they are `Big:Small` they are swappedd to be `Small: Big`

Once it is swapped, we move to the next element of the array and compare it with the 2nd, bigger element we just compared or swapped.

Like the selection sort we track the unsorted/sorted point but this time it is opposite as the first pass should *bubble* the largest value to the top. (Of course you could do it the other way)

Since it does alot more swaps with each pass in selection sort it at least is generaly faster than selection.

## Insertion Sort 

A sorting algorithm that compares the value with the portion that it has already sorted and finds a place for it to go. That is hard to explain so lets look at an example:

`[1,5,3,6]`

We start with an array containing just the first element, 1.

Then we compare the 5 with the 1 and see where it belongs in the sorted array, it belongs after the 1 so now the sorted array is `[1,5]

Then we look at the 3 and compare it with the sorted array, it is smaller than 5, but not smaller than 1 so it is **inserted** into the middle making the array: `[1,3,5]

Lastly we look at the 6, this is not smaller than the biggest value 5, so it simply gets added to the end. So we end up with [1,3,5,6].

Obviously this isnt the most complex exampl but you get the idea.

It is not particulary quick, at worse case it is O[n^2], a quadratic time complexity. However... it does have a particular use case

If the data is pretty much sorted it doesnt have much to do. In which case insertion sort is useful. It also has use as an online algorithm. If you need to sort each item coming into an otherwise sorted list its a good one for that.

Bubble sort, Insertion Sort, and Selection sort generally are the easier sorting methods but not particularly quick. For big data sets we need to be smarter, so lets look at some more complex sorting algorithm.

# Sorting on Steriods.

Due to the time complexity of simpler sorting algorithms, when we get to bigger datasets they start getting slow. Fortunatly, some clever people came up with some quicker ways of doing a sort:

The sorting methods we will look at are:

- Merge Sort
- Quick Sort
- Radix Sort

Be warned, they can be a little wierd.

## Merge Sort

This relies on a few steps:

- Splitting up an array into individual arrays
- Comparying arrays
- Merging a pair of arrays together
- Repeating the merge till the whole array is joined up.
  
## Quick Sort

Quick sort involves selecting one element called the pivit and finding  the index where the pivot should end up in the sorted array.

`[11,66,44,9,5,19]`

Quick sort involves a couple of steps.

1. First we choose a pivot point, 11 is good one. But ideally it should be the median value.
2. We first check if any numbers are greater than in on the left side, since it is the first element in the list that wont do much
3. Then we check for any elements to the right that are smaller than 11, in our case this is `9 and 5`.
4. Swap those elements in front of 11 whilst tracking how many elements have been moved (in our case that is two). The array should look like this:

`[11,9,5,66,44,19]`

We then move 11 forwards by the amount of elements we counted as less than it so now we have:

`[9,5,11,66,44,19]`

Then it repeats the process with the left side. It looks at 5 and compares it with the elements to the lieft of it to see there is anything bigger to swap with. In this case `9 and 5` swap places.

`[5,9,11,66,44,19]`

Now we have reached the end of the left side, we look at the right hand side of 11. The first element we meet is `66` and again we check if there is anthhing smaller than it, There is `19` so that swaps in front of `66` and we can move 66 forward:

`[5,9,11,19,66,44]`

Then we repeat the process with 66. Which results in swapping with 44.

It makes more sense with a longer array but its quite tricky to make happen in code!

Like Merge sort, the time complexity of this is O[n log n]

# Radix sort

So far, the sorting mechnanisms are comparison algorithms which will never be quicker than O [n log n]. However for certain use cases we might have other ways that might be more effiencient. Wwhen it comes to integers, Radix sort is a good example of this. But its a bit wierd.

Radix never comparies each value but instead looks at the digits that form up each number and sorts them into buckets between 0-9. It will be able to sort in the same number of passes our longest number.

So to do this we need functions that:

1. Digit Location - Get the digit at a certain point. You can use clever maths or just convert to string and get the character.

2. Digit Count - Counts the number of digits in each number. 

3. Most Digits - Work out the most digits in the list by using digit count.


Once we have done that we can simply have an Array with 10 arrays representing 0-9 we can push our numbers into.

Once our array has been placed into each sub-array. we can concatenate those sub arrays into a new array. 

Repeat it for the amount of times we have the highest amount of digits for and we should end up with lovely sorted digits.

In terms of time complexity `O(nk) is the generally accepted. Where k is the length of bigger digits. For really big digits, it will be worst but generally its pretty fast. And very clever.

