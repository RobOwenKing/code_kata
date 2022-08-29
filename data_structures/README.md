# RobOwenKing's Data Structures

As I was studying data structures and abstract data types, it became clear that it would be most helpful to implement simple versions of some of the most important ones myself. I decided to do this in Ruby because most of the examples I was looking at at the time were in Javascript.

In most cases, I've tried to follow test-driven design principles, that being another topic I was working on at the time.

I should note that all of them are learning experiments and, as such, contain things I would do differently in real-life applications. For example, some times I've explicitly avoided using built-in Ruby methods to do things myself. There are also things like some simple methods (eg: #empty?) and ArgumentErrors which I've implemented only once or twice in some structure as a demonstration, but decided against spending time repeating endlessly each time.

## Requirements

 - `ruby 2.6.6` (Download: (https://www.ruby-lang.org/en/downloads/)[https://www.ruby-lang.org/en/downloads/])
 - `rspec` for tests (Download: `gem install rspec`)

## Projects in order

1. Stack
    - Methods: #push(element), #pop, #peek, #size, #empty?, #clear
    - I use it [here](https://github.com/RobOwenKing/code_kata/blob/master/string_methods/parentheses.rb) to solve the Matching Parentheses problem.
2. Singly-Linked List
    - Methods: #first => returns value, #head => returns node, #last, #tail, #unshift(value), #shift, #push(value), #pop, #fetch(index) => returns value, #fetch_node(index), #find_index(value), #find_node(value), #insert(index, value), #delete_at(index), #loops?, #reverse, #reverse! (different algorithm).
3. Queue
    - I saw an interview question to implement a queue using two stacks. So that's what I did
    - Methods: #enqueue, #dequeue
4. Set
    - Methods: #add(val), #delete(val), #include?(val), #length, #union(other_set), #intersection(other_set), #difference(other_set), #subset?(other_set).
5. Priority Queue
    - Methods: #enqueue(value, priority), #dequeue, #next, #find_priority(value), #position(value), #change_priority(value, priority).
6. Binary Tree (WIP)
    - Methods: #insert(value), #include?(value), #find(value) => returns node, #min, #max, #floor(value), #ceil(value), #full?, #complete?, #perfect?, #balanced?, #degenerate?, #height, #parent(value), #delete(value), #to_a (based on depth-first in-order), #in_order (alias of #to_a), #pre_order, #post_order, #bf_order, #leaves, #count, #subtree(value), #successor(value), #previous(value), #level(value).
7. Minimum Binary Heap
    - Methods: #to_a, #root, #insert(value), #delete(value)
8. Graph
    - A class for simple graphs (no loops or multiedges)
    - Methods
        - Vertex CRUD: #add_vertex(value), #delete_vertex(value), #vertices, #order
        - Edge CRUD: #add_edge(vertex1, vertex2), #delete_edge(vertex1, vertex2), #edges, #size
        - Graph Properties: #complete?, #connected?, #directed?, #max_degree, #min_degree, #regular?, #undirected?
        - Vertex Properties: #adjacent?(vertex1, vertex2), #degree(vertex1), #neighbours(vertex2)
        - Transformations: #complement, #direct!, #lossless_undirect!, #lossy_undirect!
