# RobOwenKing's Data Structures

As I was studying data structures and abstract data types, it became clear that it would be most helpful to implement simple versions of some of the most important ones myself. I decided to do this in Ruby because most of the examples I was looking at at the time were in Javascript.

In most cases, I've tried to follow test-driven design principles, that being another topic I was working on at the time.

I should note that all of them are learning experiments and, as such, contain things I would do differently in real-life applications. For example, some times I've explicitly avoided using built-in Ruby methods to do things myself. There are also things like some simple methods (eg: #empty?) and ArgumentErrors which I've implemented only once or twice in some structure as a demonstration, but decided against spending time repeating endlessly each time.

## Projects in order
1. Stack - Ruby implementation of Javascript example by [Traversy Media](https://www.youtube.com/watch?v=wtynhUwS5hI). I use it [here](https://github.com/RobOwenKing/code_kata/blob/master/string_methods/parentheses.rb) to solve the Matching Parentheses problem. Includes: #push(element), #pop, #peek, #size, #empty?, #clear
2. Singly-Linked List - With 17 methods, it's the most fleshed-out of the classes. Includes: #first => returns value, #head => returns node, #last, #tail, #unshift(value), #shift, #push(value), #pop, #fetch(index) => returns value, #fetch_node(index), #find_index(value), #find_node(value), #insert(index, value), #delete_at(index), #loops?, #reverse, #reverse (different algorithm)
3. Queue - I saw an interview question to implement a queue using two stacks. So that's what I did. Includes: #enqueue, #dequeue
4. Set - Being a Maths graduate, I focussed on the algebraic operations of union, intersection, difference and subset. Includes: #add(val), #delete(val), #include?(val), #length, #union(other_set), #intersection(other_set), #difference(other_set), #subset?(other_set)
5. Priority Queue - Includes: #enqueue(value, priority), #dequeue, #next, #find_priority(value), #position(value), #change_priority(value, priority)
6. Binary Search Tree - The latest and probably final entry in this series, currently a work in progress. Includes: #insert(value), #include?(value), #find(value) => returns node, #min, #max, #floor(value), #ceil(value), #to_a (based on depth-first in-order), #full?, #height
