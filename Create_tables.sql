-- PEOPLE
CREATE TYPE gender AS ENUM ('male', 'female', 'none');

CREATE TYPE designation AS ENUM ('reptilian','sentient');

CREATE TABLE classifications (
    id      serial not null
        constraint classification_pk
        primary key,
    name    varchar
);

CREATE TABLE homeworld(
    id  serial not null
        constraint homeworld_pk
        primary key,
    name    varchar
);

CREATE TABLE languages(
    id serial not null
        constraint language_pk
        primary key,
    language varchar
);

CREATE TABLE species(
    id              serial not null
        constraint species_pk
        primary key,

    classification_idx integer not null
        constraint classification_fk
            references classifications,

    designation     designation,
    average_lifespan int
);

CREATE TABLE people (
    id          serial not null
        constraint people_pk
        primary key,
    name        varchar,
    height      float,
    language_idx integer not null
        constraint language_fk
            references languages,
    species_idx integer not null
        constraint specy_fk
            references species,
    homeworld_idx   integer  not null
        constraint homeworld_fk
            references homeworld
);

CREATE TABLE characters (
    id      serial not null
        constraint character_pk
        primary key,
    birthday    varchar,
    mass        float,
    gender      gender
) INHERITS (people);

CREATE TABLE color (
    id          serial not null
        constraint color_pk
        primary key,

    people_idx integer not null
        constraint people_fk
            references people,

    name        varchar
);

CREATE TABLE skin_color(
    name varchar
) INHERITS (color);

CREATE TABLE eye_color(
    name  varchar
) INHERITS (color);

-- VEHICLES

CREATE TYPE duration AS ENUM ('Hour','Day','Week','Month','Year');

CREATE TABLE starships (
    id serial not null
        constraint starship_pk
        primary key,
    hyperdrive_rating   float,
    MGLT                float
);

CREATE TABLE vehicle_classes (
    id serial not null
        constraint vehicle_class_pk
        primary key,
    name    varchar
);

CREATE TABLE manufacturers (
    id serial not null
        constraint manufacturer_pk
        primary key,
    name    varchar
);

CREATE TABLE models (
    id serial not null
        constraint model_pk
        primary key,
    name    varchar
);

CREATE TABLE vehicles (
    id serial not null
        constraint vehicle_pk
        primary key,

    manufacturer_idx  integer  not null
        constraint manufacturer_fk
            references manufacturers,

    model_idx  integer  not null
        constraint model_fk
            references models,

    name    varchar,
    cost    float,
    length  float,
    max_atmospheric_speed  float,
    crew_numbers    int,
    passenger_number    int,
    cargo_capacity  float,
    consumable      int,
    duration_type   duration
);

-- PLANETS

CREATE TABLE climates (
    id serial not null
        constraint climate_pk
        primary key,
    name    varchar
);

CREATE TABLE terrains (
    id serial not null
        constraint terrain_pk
        primary key,
    name    varchar
);

CREATE TABLE planets (
    id serial not null
        constraint planet_pk
        primary key,

    climates_idx  integer  not null
        constraint climate_fk
            references climates,

    rotation_period float,
    orbital_period  float,
    diameter        float,
    surface         float,
    population      float
);

CREATE TABLE planets_terrains (
    planets_idx  integer  not null
        constraint planet_fk
            references planets,

    terrains_idx  integer  not null
        constraint terrain_fk
            references terrains
);

CREATE TABLE planet_climates (
    planets_idx  integer  not null
        constraint planet_fk
            references planets,

    climates_idx  integer  not null
        constraint climate_fk
            references climates
);



