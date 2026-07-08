import db from './db.js';

const getAllProjects = async () => {
  const query = `
    SELECT
      p.project_id,
      p.title,
      p.description,
      p.location,
      p.project_date,
      o.organization_id,
      o.name AS organization_name
    FROM public.service_project p
    JOIN public.organization o
      ON o.organization_id = p.organization_id
    ORDER BY p.project_date ASC, p.title ASC;
  `;

  const result = await db.query(query);
  return result.rows;
};

export { getAllProjects };

