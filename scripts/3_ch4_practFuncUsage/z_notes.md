# Practical Function Usage and Optimization

## 4.1 Using Functions in Queries and Joins

**Goal:** learn how to embed both system and user-defined functions (scalar and table-valued) directly inside ```SELECT```, ```JOIN```, and ```WHERE``` clauses.

### Using a Scalar Function Directly in Queries

We used a function that we had used and persisted data with to create a new column we called CategoryLive, and when we compared it with Category it was the same. We learned that the live call is recalculated per row and is slower for larger sets.

Part B: we used ```WHERE``` and ```ORDER BY``` to return top 20 results and return by Category, derived by function.

Part D: Understanding Table-Valued Functions (TVFs)

Unlike scalar functions that return a single value (e.g., one derived category per word),
table-valued functions return a virtual table.

`You can think of them as mini sub-queries that you can join to your actual tables.`

#### Typical Syntax

```SQL
SELECT ...
FROM SomeTable AS t
CROSS APPLY dbo.SomeTableValuedFunction(t.SomeColumn, ...)
```

 

## 4.2 Combining UDFs with Views and Stored Procedures

## Performance and Execution Plans

## Error Handling and NULL Behavior in Functions
