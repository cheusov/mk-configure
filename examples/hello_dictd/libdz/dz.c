int fake3 (void);

int fake3 (void)
{
  return 3;
}

/* fake must not be exported */
int fake2 (void);

int fake2 (void)
{
  return 2;
}
