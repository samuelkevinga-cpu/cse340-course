-- Week 02 - Verification queries

-- Organizations
SELECT organization_id, name, contact_email, logo_filename
FROM public.organization
ORDER BY organization_id;

-- Projects (raw)
SELECT project_id, organization_id, project_date, title, location
FROM public.service_project
ORDER BY project_date, title;

-- Projects + Organization
SELECT
  p.project_date,
  p.title,
  o.name AS organization_name
FROM public.service_project p
JOIN public.organization o
  ON o.organization_id = p.organization_id
ORDER BY p.project_date, p.title;

-- Counts per organization
SELECT
  o.organization_id,
  o.name,
  COUNT(p.project_id) AS project_count
FROM public.organization o
LEFT JOIN public.service_project p
  ON p.organization_id = o.organization_id
GROUP BY o.organization_id, o.name
ORDER BY o.organization_id;

-- Categories
SELECT category_id, name
FROM public.category
ORDER BY name;

-- Project-category links (many-to-many)
SELECT
  p.title,
  c.name AS category_name
FROM public.project_category pc
JOIN public.service_project p ON p.project_id = pc.project_id
JOIN public.category c ON c.category_id = pc.category_id
ORDER BY p.title, c.name;

