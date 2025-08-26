-- name: CreateEntry :one
INSERT INTO entries (account_id, amount)
VALUES ($1, $2)
RETURNING id, account_id, amount, created_at;

-- name: GetEntry :one
SELECT id, account_id, amount, created_at
FROM entries
WHERE id = $1;

-- name: ListEntries :many
SELECT id, account_id, amount, created_at
FROM entries
WHERE account_id = $1
ORDER BY id DESC
LIMIT $2 OFFSET $3;

-- name: DeleteEntry :exec
DELETE FROM entries
WHERE id = $1;


--- Get all entries for a specific account, ordered by newest
-- name: ListEntriesByAccount :many
SELECT * 
FROM entries
WHERE account_id = $1
ORDER BY created_at DESC
LIMIT $2 OFFSET $3;
