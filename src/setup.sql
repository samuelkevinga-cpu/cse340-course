-- Organizations (created in a Week 02 learning activity)

CREATE TABLE IF NOT EXISTS public.organization (
  organization_id INTEGER PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  contact_email VARCHAR(255) NOT NULL,
  logo_filename VARCHAR(255) NOT NULL
);

INSERT INTO public.organization (organization_id, name, description, contact_email, logo_filename)
VALUES
  (1, 'BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
  (2, 'GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
  (3, 'UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png')
ON CONFLICT (organization_id) DO NOTHING;

--Service Projects (Week 02 Team Activity)
--Every service project belongs to exactly one organization.
CREATE TABLE IF NOT EXISTS public.service_project (
  project_id INTEGER PRIMARY KEY,
  organization_id INTEGER NOT NULL REFERENCES public.organization (organization_id) ON DELETE CASCADE,
  title VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR(150) NOT NULL,
  project_date DATE NOT NULL
);

INSERT INTO public.service_project (project_id, organization_id, title, description, location, project_date)
VALUES
  -- Organization 1: BrightFuture Builders 
  (1, 1, 'Wheelchair Ramp Build', 'Build accessible wheelchair ramps for homes of elderly residents.', '312 Oak Street', '2026-08-15'),
  (2, 1, 'Community Center Repairs', 'Repair drywall, paint, and fix lighting at the neighborhood community center.', 'Downtown Community Center', '2026-09-05'),
  (3, 1, 'Playground Construction', 'Assemble and install new playground equipment at the city park.', 'Maple Street Park', '2026-09-19'),
  (4, 1, 'Habitat Home Framing', 'Help frame walls and set trusses for a new affordable home.', '48 Sunrise Avenue', '2026-10-03'),
  (5, 1, 'Public Bench Installation', 'Construct and install benches along the riverside walking trail.', 'Riverside Trail', '2026-10-17'),

  -- Organization 2: GreenHarvest Growers 
  (6, 2, 'Community Garden Planting', 'Prepare beds and plant vegetables in the shared community garden.', 'Eastside Community Garden', '2026-08-22'),
  (7, 2, 'Harvest and Donate Day', 'Harvest fresh produce and deliver it to the local food bank.', 'GreenHarvest Main Plot', '2026-09-12'),
  (8, 2, 'Composting Workshop', 'Teach neighbors how to build and maintain a backyard compost bin.', 'Neighborhood Learning Hub', '2026-09-26'),
  (9, 2, 'School Garden Setup', 'Install raised garden beds and irrigation at the elementary school.', 'Lincoln Elementary School', '2026-10-10'),
  (10, 2, 'Farmers Market Booth', 'Run an educational booth on sustainable growing at the farmers market.', 'City Farmers Market', '2026-11-14'),

  -- Organization 3: UnityServe Volunteers
  (11, 3, 'Winter Coat Drive', 'Collect, sort, and distribute winter coats to families in need.', 'UnityServe Warehouse', '2026-08-18'),
  (12, 3, 'Senior Meal Delivery', 'Prepare and deliver warm meals to homebound seniors.', 'Community Kitchen', '2026-09-08'),
  (13, 3, 'Neighborhood Cleanup', 'Pick up litter and beautify streets in the historic district.', 'Historic District', '2026-09-29'),
  (14, 3, 'Homeless Shelter Support', 'Serve meals and organize donations at the local shelter.', 'Hope Street Shelter', '2026-10-06'),
  (15, 3, 'Back-to-School Supply Drive', 'Assemble and hand out school supply kits for students.', 'UnityServe Warehouse', '2026-10-20')
ON CONFLICT (project_id) DO NOTHING;