-- Lib event tests.

create or replace function lib_test.test_case_lib_event_create_fail() returns void as
$$
begin
  begin
    perform lib_event.create(null);
  exception
    when not_null_violation then
      perform lib_test.assert_equal(sqlerrm, 'null value in column "event_type" violates not-null constraint');
      return;
  end;
  perform lib_test.fail('should not go there');
end;
$$ language plpgsql;

create or replace function lib_test.test_case_lib_event_create() returns void as
$$
declare
  event__id uuid;
begin
  event__id = lib_event.create(type$ => 'iam.user.created', payload$ => '{"actor": 1, "occurred_at": "2015-05-22T10:56:04.949Z", "created_at": "2015-05-22T10:56:04.949Z", "data": { "payload": true }}');
  perform lib_test.assert_not_null(event__id, 'event not created');
end;
$$ language plpgsql;

create or replace function lib_test.test_case_lib_event_get_created_event() returns void as
$$
declare
  event__id$ uuid;
  count$     int;
begin
  event__id$ = lib_event.create(type$ => 'iam.user.created', payload$ => '{"actor": 1, "occurred_at": "2015-05-22T10:56:04.949Z", "created_at": "2015-05-22T10:56:04.949Z", "data": { "payload": true }}');
  select count(1) from lib_event.events where id = event__id$ into count$;
  perform lib_test.assert_equal(1, count$);
end;
$$ language plpgsql;
