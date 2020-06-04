create table if not exists lib_event.event
(
  event__id         uuid not null default public.gen_random_uuid(),
  event_type        text not null,
  payload           jsonb default '{}',
  primary key(event__id)
);
create index on lib_event.event (event_type);

create or replace function lib_event.create(
  type$     text,
  id$       uuid default public.gen_random_uuid(),
  payload$  jsonb default '{}'::jsonb
) returns uuid as $$
begin

  insert into lib_event.event (event__id, event_type, payload)
    values (id$, type$, payload$);

  perform pg_notify('lib_event.created'::text, id$::text);
  return id$;
end;
$$ language plpgsql;
