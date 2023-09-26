

select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProjects..CovidDeaths$
order by 1,2 

-- looking at total cases vs total deaths
-- shows the likelihood if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/Total_cases)*100 AS DeathPercentage
from PortfolioProjects..CovidDeaths$
where location like '%nigeria%'
Order by 1,2 

--looking at Total cases vs Population
-- shows what % of population got covid

select location, date, total_cases, population, (total_cases/population)*100 AS PercentPopulationInfected
from PortfolioProjects..CovidDeaths$
where location like '%nigeria%'
Order by 1,2 

--looking at countries with highest infection rate compared to population

select location, population, MAX(total_cases) AS highestinfectioncount, MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProjects..CovidDeaths$
group by location , population
order by 4 desc

--showing countries with highest death count per population
select location,MAX( cast(Total_deaths as int)) as TotaldeathCount
from PortfolioProjects..CovidDeaths$
where continent is not null
group by location 
order by TotaldeathCount desc

--lets break things down by continent
--showing continents with the

select continent, MAX(cast(Total_deaths as int)) as TotaldeathCount
from PortfolioProjects..CovidDeaths$
where continent is not null
group by continent 
order by TotaldeathCount desc

--GLOBAL NUMBERS
select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int )) as total_deaths,SUM(cast(new_deaths as int))/SUM(New_cases)*100 AS DeathPercentage
From PortfolioProjects..CovidDeaths$
where continent is not null
--group by date
order by 1,2

Select *
from PortfolioProjects..CovidDeaths$ dea
Join PortfolioProjects..CovidVaccinations$ vac
   On dea.location = vac.location
   and dea.date=vac.date


--looking at total population vs vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProjects..CovidDeaths$ dea
Join PortfolioProjects..CovidVaccinations$ vac
   On dea.location = vac.location
   and dea.date=vac.date
where dea.continent is not null
order by 1,2,3