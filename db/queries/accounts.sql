-- name: CreateAccount :one
INSERT INTO account (owner, balance, currency)
VALUES ($1, $2, $3)
RETURNING id, owner, balance, currency, created_at;

-- name: GetAccount :one
SELECT id, owner, balance, currency, created_at
FROM account
WHERE id = $1;

-- name: GetAccountForUpdate :one
SELECT id, owner, balance, currency, created_at
FROM account
WHERE id = $1
FOR UPDATE;

-- name: ListAccounts :many
SELECT id, owner, balance, currency, created_at
FROM account
ORDER BY id
LIMIT $1 OFFSET $2;

-- name: UpdateAccount :one
UPDATE account
SET balance = $2
WHERE id = $1
RETURNING id, owner, balance, currency, created_at;

-- name: DeleteAccount :exec
DELETE FROM account
WHERE id = $1;



-- name: AddAccountBalance :one
UPDATE account
SET balance = balance + sqlc.arg(amount)
WHERE id = sqlc.arg(id)
RETURNING *;
