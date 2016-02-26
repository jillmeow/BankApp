create or replace trigger calculateTotalLoan
before insert or update or delete of amount on loan
for each row
begin
  if inserting then
  update bank_branch
  set total_loan = total_loan + :NEW.amount
  where brcode = :New.bCode and branchNo = :New.bNum;

  elsif updating then
  update bank_branch
  set total_loan = total_loan + :NEW.amount - :OLD.amount
  where brcode = :OLD.bCode and branchNo = :OLD.bNum;

  else
  update bank_branch
  set total_loan = total_loan - :OLD.amount
  where brcode = :OLD.bCode and branchNo = :OLD.bNum;

  END IF;
END;
/

create or replace trigger updateTotalLoan
before update of bNum on loan
for each row
begin
update bank_branch
set total_loan = total_loan + :NEW.amount
where brcode = :New.bCode and branchNo = :New.bNum;

update bank_branch
set total_loan = total_loan - :OLD.amount
where brCode = :OLD.bCode and branchNo = :OLD.bNum;
END;
/

