# RobOwenKing's Data Structures

As I was studying data structures and abstract data types, it became clear that it would be most helpful to implement simple versions of some of the most important ones myself. I decided to do this in Ruby because most of the examples I was looking at at the time were in Javascript.

In most cases, I've tried to follow test-driven design principles, that being another topic I was working on at the time.

I should note that all of them are learning experiments and, as such, contain things I would do differently in real-life applications. For example, some times I've explicitly avoided using built-in Ruby methods to do things myself. There are also things like some simple methods (eg: #empty?) and ArgumentErrors which I've implemented only once or twice in some structure as a demonstration, but decided against spending time repeating endlessly each time.

## Projects in order
1. Stack - Ruby implementation of Javascript example by [Traversy Media](https://www.youtube.com/watch?v=wtynhUwS5hI). I use it [here](https://github.com/RobOwenKing/code_kata/blob/master/string_methods/parentheses.rb) to solve the Matching Parentheses problem.
2. Singly-Linked List - Including 17 methods, it's the most fleshed-out of the classes.
3. Queue - I saw an interview question to implement a queue using two stacks. So that's what I did. With only enqueue and dequeue, it's the least fleshed-out.
4. Set - Being a Maths graduate, I focussed on the algebraic operations of union, intersection, difference and subset.
5. Priority Queue
