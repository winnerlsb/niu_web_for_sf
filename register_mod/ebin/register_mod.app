
{application, register_mod, [
  {description, ""},
  {vsn, "1.0"},
  {modules, []},
  {registered, [register_mod_sup]},
  {applications, [
    kernel,
    stdlib
  ]},
  {mod, {register_mod_app, []}},
  {env, []}
]}.
