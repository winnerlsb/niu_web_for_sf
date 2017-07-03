
{application, dispatcher_mod, [
  {description, ""},
  {vsn, "1.0"},
  {modules, []},
  {registered, [dispatcher_mod_sup]},
  {applications, [
    kernel,
    stdlib,
    cowboy
  ]},
  {mod, {dispatcher_mod_app, []}},
  {env, []}
]}.
