SELECT * FROM CovidDeaths
SELECT * FROM CovidVaccinations

-- SELECTING the data that is used

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2

-- looking at total cases vs total deaths 
-- shows likelyhood of dying in your country if you get covid 
SELECT location, date, total_cases, total_deaths, round((total_deaths/total_cases)*100, 2) as DeathPercentage
FROM CovidDeaths WHERE location LIKE '%india%'
ORDER BY 1,2

-- looking at total cases vs population
-- shows what % of population got covid
SELECT location, date, total_cases, population, (1.0*total_cases/population)*100 as PerPopulationInfected
FROM CovidDeaths WHERE location LIKE '%india%'
ORDER BY 1,2

--countries with highest infection rate compared with population
SELECT location,population, MAX(total_cases) as HighestInfectionCount, MAX((1.0*total_cases/population))*100 as PerPopulationInfected
FROM CovidDeaths -- WHERE location LIKE '%states%'
GROUP BY location, population
ORDER BY PerPopulationInfected DESC
 
--countries with highest death count per polulation
SELECT location, MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths  WHERE continent is NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- break down by continent
SELECT continent, MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths  WHERE continent is NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- only these
SELECT location, MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths  WHERE continent is NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


-- Global data
SELECT  sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
FROM CovidDeaths WHERE continent is not null
--GROUP BY date
ORDER BY 1,2


--join

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(CONVERT(int, vac.new_vaccinations)) OVER(Partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVac
from CovidDeaths as dea 
join CovidVaccinations vac on dea.location = vac.location and dea.date=vac.date 
WHERE dea.continent is NOT NULL
ORDER BY 2,3


--CTE
WITH PopVsVac AS (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(CONVERT(int, vac.new_vaccinations)) OVER(Partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVac
from CovidDeaths as dea 
join CovidVaccinations vac on dea.location = vac.location and dea.date=vac.date 
WHERE dea.continent is NOT NULL)
SELECT *, (1.0*RollingPeopleVac/population)*100 From PopVsVac  
ORDER BY 2,3

-- creating view for future use
DROP VIEW PerPopVac;
GO
CREATE VIEW PerPopVac AS 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(CONVERT(int, vac.new_vaccinations)) OVER(Partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVac
from CovidDeaths as dea 
join CovidVaccinations vac on dea.location = vac.location and dea.date=vac.date 
WHERE dea.continent is NOT NULL

SELECT * FROM PerPopVac
