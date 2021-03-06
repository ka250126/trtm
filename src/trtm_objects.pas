// Dealing with objects

procedure TFormTRTM.InitObjectsList;
Var
  cnt : integer;
begin
  for cnt := 1 to MAX_ID do
  begin
    ListBoxObjects.Items[cnt-1] := IntToStr( cnt );
  end;
end;

procedure TFormTRTM.FillListBoxObjects;
Var
  cnt : word;
begin
  ListBoxObjects.Clear;
  for cnt := 1 to MAX_ID do
  begin
    ListBoxObjects.Items.Add( IntToStr(cnt) +'. ' + trtm_main_table[cnt].desc );
  end;
end;


procedure TFormTRTM.ParseObjLine( sobj : string; Var obj : TTRTM_Objects_Set );
Var
  spar  : string;
  cnt,
  len   : word;

begin
  sobj := trim( sobj );
  spar := '';
  obj  := nil;
  cnt  := 1;
  len  := length( sobj );
  if ( len = 0 )then
  begin
    Exit;
  end;
  while ( cnt <= len ) do
  begin
    if ( sobj[cnt] in ['0' .. '9'] ) then
    begin
      spar := spar + sobj[cnt];
    end else if (( spar <> '' ) and (spar <> ' ' ) ) then
    begin
      SetLength( obj, length(obj) + 1 );
      obj[High(obj)] := StrToInt( spar );
      spar := '';
    end;
    inc( cnt );
  end;
  if ( ( spar <> '' ) and (spar <> ' ' ) ) then
  begin
    SetLength( obj, length(obj) + 1 );
    obj[High(obj)] := StrToInt( spar );
    spar := '';
  end;
end;

procedure TFormTRTM.ParseObjects( sobj : string; sbobj : string; Var obj : word; Var bobj : TTRTM_Objects_Set );
begin
  obj  := 0;
  bobj := nil;
  try
    // get the object: there must be the only one object in a cell
    if trim(sobj) <> '' then
      obj := StrToInt( trim( sobj ) );
    // get bads. There can be many of them.
    ParseObjLine( sbobj, bobj );
  except
  end;
end;

