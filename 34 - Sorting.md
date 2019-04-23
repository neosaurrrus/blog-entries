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

Its not very effecient but its got given a name so here we are. `Selection sort - Don't do it` probably should be its tagline.

## Bubble Sort

The sorting algorithm with the cutest name. It aint the best, but its more interesting than selection sort.

The main idea is that Bubble Sort compares pairs as it loops through the array, if they are `Big:Small` they are swappedd to be `Small: Big`

Once it is swapped, we move to the next element of the array and compare it with the 2nd, bigger element we just compared or swapped.

Like the selection sort we track the unsorted/sorted point but this time it is opposite as the first pass should *bubble* the largest value to the top. (Of course you could do it the other way)

Since it does alot more swaps with each pass in selection sort it at least is generaly faster than selection.
