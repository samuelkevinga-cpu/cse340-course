import db from './db.js';

const getAllProjects = async () => {
  const query = `
    SELECT
      p.title,
      p.description,
      p.location,
      p.project_date,
      o.name AS organization_name
    FROM public.service_project p
    JOIN public.organization o
      ON o.organization_id = p.organization_id
    ORDER BY p.project_date ASC, p.title ASC;
  `;

  const result = await db.query(query);
  return result.rows;
};

const getProjectsByOrganizationId = async (organizationId) => {
  const query = `
    SELECT
      project_id,
      organization_id,
      title,
      description,
      location,
      project_date
    FROM public.service_project
    WHERE organization_id = $1
    ORDER BY project_date;
  `;

  const queryParams = [organizationId];
  const result = await db.query(query, queryParams);

  return result.rows;
};

export { getAllProjects, getProjectsByOrganizationId };

