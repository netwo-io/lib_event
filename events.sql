create or replace view lib_event.events as
  select event__id as id, event_type as type, payload
  from lib_event.event
  order by id;
