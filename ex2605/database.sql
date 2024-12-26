SELECT p.name AS name, pr.name AS name
FROM products p
JOIN providers pr ON p.id_providers = pr.id
WHERE p.id_categories = 6;
