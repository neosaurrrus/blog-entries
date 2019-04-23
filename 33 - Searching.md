# Classic searching methods

In computer science there is various methods of searching, for reference lets learn about them. Using Javascript... but not using `indexOf` or `array.find`

## Why do we care aboout searching algorithms?

Mostly because its such a common thing to do, if given a list of things, we need a way of quickly checking if we have a particular item within it.

So lets see what we can find out.

## Linear Search

If you have a dictionary and you want to find the word "otter", one way of doing it is to simply start at the first word, probably "a" and then go onto "Aardvark", till eventually we find badger or we go through the whole dictionary.

!(Just wanted a picture of an Aardvark)[https://github.com/neosaurrrus/blog-entries/pics/aardvark-baby.jpg]

This is quite easy to implement but as it should be fairly easy to see that it quite slow. However, if you brought a terrible dictionary where the words were in a random order, then all you reall could do is search them one by one.

Linear search is now Javascript does alot of its built in searching:

- indexOf
- includes
- find
- findIndex

For constantly small arrays, or unsorted values, there is little really wrong with Linear Search, i.e one ofthe JS helper methods. Just watch out if it is sorted and dealing with a non-trivial amount of items.

In terms of time complexity, it is O(n)... a linear time complexity for linear search.

## Binary Search

Binary Search can be much quicker than Linear search.

If we go back to the dictionary example searching for "otter" another way we could do it is to open the dictionary at the half way poing and check what we see. 

So, if we do that we get "leopard". Next, we then compare it to "otter". As its less than otter, alphabetically we know that *everything before leopard wont have otter in, as the list of words is sorted*... we have just saved ourselves the hassle of sarch through half the dictionary...

Our next step is to then pick the wayway point between leopard and the end of the diction and repear the process over and over till we eventually home in on "otter". I think this is actually pretty similar to how we would actually search through a dictionary in real life.

We implement a Divide and Conquer algorithm to do this.

We have two pointers `left` and `right` in the array.  

### An example of Binary Search

```js
function binarySearch(arr, value){
    let left = 0
    let right = arr.length - 1
    let middle = Math.floor((right+left)/2);

    while ((arr[middle] !== value && left<=right)){
        if (value > arr[middle])        {left = middle+1} 
        else if (value < arr[middle])   {right = middle-1}
        middle = Math.floor((right + left) / 2)
    }

    // if (arr[middle] === value) return middle
    // else return -1

    return arr[middle] === value ? middle : -1
}

console.log(binarySearch([1,2,3,4,5,6,7,8], 6)) //returns 5
```

So as you can see we move the left and right pointers based on where middle currently is at in relation to either pointer. 

In terms on time complexity it is O log n, faster than linear. Thats great, the number of operations decreases relative to the number of elements. The only problem is that it only works on sorted lists.

## Searching for substrings in a larger string.

If you have a string and you want to check for instances of a certain combination of letters within it  ("Ann Bans Bananas" looking for "an"), you might go for an approach with two loops, one that goes through the longer string and then another that then checks each letter of the subString. My solution instead used slice to compare the sliced chunk wherever it found a match:

```js
function subStringCount(str, subStr){
    let count = 0
    Array.from(str).forEach( (letter,index) => {
        if (letter === subStr[0]){
            if (str.slice(index, index+subStr.length) === subStr) count++
        }
    })
    return count
}
```