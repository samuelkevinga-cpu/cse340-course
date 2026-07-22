import db from './db.js';

const getUpcomingProjects = async (numberOfProjects) => {
  const query = `
    SELECT
      p.project_id,
      p.title,
      p.description,
      p.location,
      p.project_date AS date,
      p.organization_id,
      o.name AS organization_name
    FROM public.service_project p
    JOIN public.organization o
      ON o.organization_id = p.organization_id
    WHERE p.project_date >= CURRENT_DATE
    ORDER BY p.project_date ASC, p.title ASC
    LIMIT $1;
  `;

  const queryParams = [numberOfProjects];
  const result = await db.query(query, queryParams);
  return result.rows;
};

const getProjectDetails = async (projectId) => {
  const query = `
    SELECT
      p.project_id,
      p.title,
      p.description,
      p.project_date AS date,
      p.location,
      p.organization_id,
      o.name AS organization_name
    FROM public.service_project p
    JOIN public.organization o
      ON o.organization_id = p.organization_id
    WHERE p.project_id = $1;
  `;

  const queryParams = [projectId];
  const result = await db.query(query, queryParams);

  return result.rows.length > 0 ? result.rows[0] : null;
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

const createProject = async (title, description, location, date, organizationId) => {
  const query = `
    INSERT INTO public.service_project (
      project_id,
      title,
      description,
      location,
      project_date,
      organization_id
    )
    VALUES (
      (SELECT COALESCE(MAX(project_id), 0) + 1 FROM public.service_project),
      $1, $2, $3, $4, $5
    )
    RETURNING project_id;
  `;

  const queryParams = [title, description, location, date, organizationId];
  const result = await db.query(query, queryParams);

  if (result.rows.length === 0) {
    throw new Error('Failed to create project');
  }

  if (process.env.ENABLE_SQL_LOGGING === 'true') {
    console.log('Created new project with ID:', result.rows[0].project_id);
  }

  return result.rows[0].project_id;
};

const updateProject = async (projectId, title, description, location, date, organizationId) => {
  const query = `
    UPDATE public.service_project
    SET
      title = $1,
      description = $2,
      location = $3,
      project_date = $4,
      organization_id = $5
    WHERE project_id = $6
    RETURNING project_id;
  `;

  const queryParams = [title, description, location, date, organizationId, projectId];
  const result = await db.query(query, queryParams);

  if (result.rows.length === 0) {
    throw new Error('Project not found');
  }

  if (process.env.ENABLE_SQL_LOGGING === 'true') {
    console.log('Updated project with ID:', projectId);
  }

  return result.rows[0].project_id;
};

export {
  getUpcomingProjects,
  getProjectDetails,
  getProjectsByOrganizationId,
  createProject,
  updateProject
};

