-- library for event recording

drop schema if exists lib_event cascade;
create schema lib_event;
grant usage on schema lib_event to public;
set search_path to pg_catalog;

\ir event.sql
\ir events.sql
