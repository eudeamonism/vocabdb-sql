# Concepts and Process for Anagram Puzzle

## Vocabulary

### Computed Column

**What does it do and why do we use it?**

- per-row derived value
- It does not store “all anagrams” of ```elif```; rather, you find anagrams by looking for other rows whose SortedWord equals ```elif```
- used to identify anagrams

## Sorting Function Diagram

```SQL
FUNCTION fn_SortLetters(word)
    1. Make a list of numbers from 1 → length of the word.
    2. Use those numbers to pull each letter from the word.
    3. Sort those letters alphabetically (A–Z).
    4. Join them back into one string.
    5. Return that string.
END FUNCTION
```

| Step | Operation           | Result     |
| ---- | ------------------- | ---------- |
| 1    | Break into letters  | l, i, f, e |
| 2    | Sort alphabetically | e, f, i, l |
| 3    | Join together       | `'efil'`   |
| 4    | Return value        | `'EFIL'`   |

### This is not stored, rather computed

```SQL
Table Definition
─────────────────────────────
WordID     int
Word       nvarchar(128)
CreatedAt  datetime2
SortedWord AS dbo.fn_SortLetters(Word)
```

## Function stays in DB

- the function lives in the database, not in your .sql file.

```text
VocabDB
 └── Programmability
     └── Functions
         └── Scalar-valued Functions
             └── dbo.fn_SortLetters
```
