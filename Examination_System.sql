
create database Examination_System;
use Examination_System;
go
create schema std
go
create schema qp


create table Exam
(
[ID] int identity(1,1) primary key,
[StartTime]  DateTime not null,
[EndTime] DateTime not null
)

create table Course(
Id int primary key identity (1,1),
Name varchar(20),
Description varchar(100), 
MinDegree int,
MaxDegree int
)


create table qp.QuestionPool(     
ID int primary key identity (1,1),
Question varchar(100) not null,
ExamID int foreign key references Exam ( ID  ) on delete cascade on update cascade,
Mark int NOT NULL,
CourseID int foreign key references Course  ( ID  ) on delete cascade on update cascade
)



 create table Intake 
 (
 [ID] int identity(1,1) primary key,
 [Name] nvarchar(50) not null
 )


 create table Branch  
 (
 [ID] int identity(1,1) primary key,
 [Name] nvarchar(50) not null,
 )



 create table Track   
 (
 [ID] int identity(1,1) primary key,
 [Name] nvarchar(50) not null,
 )


 create table BranchTrackIntake
 (
 [IntakeID] int ,
 [BranchID] int,
 [TrackID] int,
  foreign key([TrackID])references Track (ID) on delete cascade on update cascade,
  foreign key([BranchID])references Branch(ID) on delete cascade on update cascade,
  foreign key([IntakeID])references Intake(ID) on delete cascade on update cascade,
  primary key([TrackID],[BranchID],[IntakeID])
 )
 create table LogIn    
(
id int primary key identity (1,1),
Password varchar(25),
Email varchar(25),

)
create table Instructor 
(
  ID int primary key identity (1,1),
  [Name] varchar(15) not null,
  MobilePhone varchar(11) null,
  Gender char(1) not null,
  [Address] varchar(100) ,
  IntakeID int not null,
  BranchID int not null,
  foreign key(IntakeID) references Intake(ID) on delete cascade on update cascade,
  LogInId int foreign key references LogIn ( id  ) on delete cascade on update cascade
  
)



create table std.Student
 (
  [ID] int identity(1,1) primary key,
  [Name] nvarchar(50) not null, 
  [Gender] char(1)  not null,
  [Address] nvarchar(50) not null,
  [MobilePhone]char(11) not null,
  [IntakeID] int not null,
  [BranchID] int not null,
  [TrackID] int not null,
  foreign key([TrackID])references Track (ID) on delete cascade on update cascade,
  foreign key([BranchID])references Branch(ID)on delete cascade on update cascade,
  foreign key([IntakeID])references Intake(ID)on delete cascade on update cascade,
  [LogInId] int foreign key references LogIn ( id  )on delete cascade on update cascade
  )

create table std.StudentExam 
(
 [StudentID] int not null,
 [ExamID] int not null,
 [Result] int not null,
 [Degree] int not null,
 [InstructorID] int not null,
 foreign key([ExamID])references Exam(ID) on delete cascade on update cascade,
 foreign key([StudentID])references std.Student(ID) on delete cascade on update cascade,
 foreign key([InstructorID])references Instructor(ID),
  primary key(StudentID,ExamID)
)
 
 

 create table std.StudentAnswer   
(
 StudentID int,
 QuestionID int,
 primary key(StudentID,QuestionID),
 foreign key(StudentID)references std.Student(ID) on delete cascade on update cascade,
 foreign key(QuestionID)references qp.QuestionPool(ID) on delete cascade on update cascade

)




                    
create table Teach(      
 
 InstructorID int foreign key references Instructor(ID) on delete cascade on update cascade,
 StudentId int foreign key references std.Student (ID),
 CourseID int foreign key references Course(ID) 
 CONSTRAINT PK_Teach PRIMARY KEY (InstructorId,StudentId,CourseID)
)



create table InstructorHasCourse(     

InstructorID int foreign key references Instructor(ID) on delete cascade on update cascade,
CourseID int foreign key references Course(ID) on delete cascade on update cascade,
CONSTRAINT PK_IHC PRIMARY KEY (InstructorId,CourseID)
)

create table Manager(    
ManagerID int NOT NULL,
InstructorID int foreign key references Instructor(ID) on delete cascade on update cascade,
CONSTRAINT PK_Manager PRIMARY KEY (ManagerID,InstructorId)
)




create table qp.MCQ(  
ID int primary key identity (1,1),
QuestionID int foreign key references qp.QuestionPool  ( ID  )on delete cascade on update cascade,
CorrectAnswer varchar(50)
)



create table qp.Choise    
(
  ID int not null primary key identity (1,1),
  MCQID int not null ,
  foreign key(MCQID) references qp.MCQ(ID)on delete cascade on update cascade,
  Choises varchar(15),
  ISTrue varchar(15)
)

create table qp.TF   
(
 ID int primary key identity (1,1),
 CorrectAnswer char(1) not null,
 QuestionID int not null,
 foreign key(QuestionID) references qp.QuestionPool(ID) on delete cascade on update cascade, 
)

create table qp.[Text] 
(
 ID int primary key identity (1,1),
 CorrectAnswer varchar(500) not null,
 QuestionID int not null,
 foreign key(QuestionID) references qp.QuestionPool(ID)on delete cascade on update cascade, 
)

create table std.STF
(
 ID int primary key identity (1,1),
 Answer char(1) not null,
 StudentID int not null,
 foreign key(StudentID) references std.Student(ID)on delete cascade on update cascade
)

create table std.SText
(
 ID int primary key identity (1,1),
 Answer varchar(500) not null,
 StudentID int not null,
 foreign key(StudentID) references std.Student(ID) on delete cascade on update cascade
)

create table std.SMCQ
(
 ID int primary key identity (1,1),
 Answer varchar(15) not null,
 StudentID int not null,
 foreign key(StudentID) references std.Student(ID) on delete cascade on update cascade
)
 


insert into[dbo].[Branch] values('Assiut'),('Minia'),('Luxor'),('Ismailia')

insert into [dbo].[Track] values('Full Stack'),('3D Animation'),('Embedded system')

insert into [dbo].[Intake] values('I1'),('I2'),('I3')

insert into [dbo].[LogIn] values('123','Ahmed@.com')
insert into [dbo].[LogIn] values('123','Asmaa@.com' )
insert into [dbo].[LogIn] values('123','Androw@.com' )
insert into [dbo].[LogIn] values('123','Basmam@.com' )
insert into [dbo].[LogIn] values('123','mohammed@')

insert into [std].[Student] values('ahmed','M','Assiut',01235455467,1,1,1,1)
insert into [std].[Student] values('Asmaa','F','Assiut',01235455467,1,1,1,2)

insert into [dbo].[Instructor] values('Androw',01235455467,'M','Assiut',1,1,3)
insert into [dbo].[Instructor] values('Basmam',01235455467,'F','Assiut',1,1,4)
insert into [dbo].[Instructor] values('mohammed',01235455467,'F','Assiut',1,1,5)

insert into [dbo].[Manager] values(1,1)

insert into [dbo].[Course] values('C#','xsvfsefavavas',10,20),('MVC','hkascjadfcdac',10,20),('SQl Server','csefvsdvfss',10,20),('linq','cjsvfdgvf',10,20)

insert into [dbo].[InstructorHasCourse]values(1,4)




------------------------------------------------------------------------------------------------
-------------------------------------------Nermeen Procedures-------------------------------------

create proc deletequestio(@instructorid int, @courseid int,@questiontype varchar(20) ,@idquestion int)
as
begin
    declare @id int
    set @id=
	(
	 select InstructorID from [dbo].[InstructorHasCourse]
	 where CourseID=@courseid
	)
	if(@instructorid=@id)	
	begin
	if(@questiontype='ft')
	begin

	 delete from [qp].[TF] where QuestionID=@idquestion;
	 delete from [qp].[QuestionPool] where ID=@idquestion;
	 end
	 if(@questiontype='msq')
	begin

	 delete from [qp].[MCQ] where QuestionID=@idquestion;
	 delete from [qp].[QuestionPool] where ID=@idquestion;
	 end
	 if(@questiontype='text')
	begin

	 delete from [qp].[Text] where QuestionID=@idquestion;
	 delete from [qp].[QuestionPool] where ID=@idquestion;
	 end
	end
	else 
	begin
	 print('false')
	end
			
end

------------------------------------------------------------------------------------------------------------------------------


create proc addinstructor(@instructorusername varchar(15), @Name varchar(15),@MobilePhone varchar(11),@Gender
char(1),@Address varchar(100),@IntakeID int,@BranchID int,@LogInId int)
as
begin
declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
    insert into [dbo].[Instructor] values ( @Name ,@MobilePhone ,@Gender
,@Address ,@IntakeID ,@BranchID ,@LogInId )
 end
 else
 begin
  print('folse')
 end

end

------------------------------------------------------------------------------------------------------------------------------
create proc loginproc(@email varchar(25),@pass varchar(25))
as 
begin
 declare @id int
 declare @usernameinstructor int
 declare @usernamestudent int
 set @id=(select [id] from [dbo].[LogIn] where [Password]=@pass and [Email]=@email)
 set @usernameinstructor=(select [LogInId] from [dbo].[Instructor] where [LogInId]=@id)
 set @usernamestudent=(select [LogInId] from [std].[Student] where [LogInId]=@id)

  if(@id=@usernameinstructor)
  begin
   select [Name] as Instructor from [dbo].[Instructor] where [LogInId]=@id
  
  end
   if(@id=@usernamestudent)
  begin
   select [Name] as Student from [std].[Student] where [LogInId]=@id
   
  end
end

------------------------------------------------------------------------------------------------------------------------------


CREATE  proc updatetrack(@InstructorUserName varchar(15),@valueupdate varchar(50) ,@id1 int)
as
begin
   declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
 UPDATE  [dbo].[Track] set  [Name]=@valueupdate  where [ID]=@id1
print( 'update track')
 end
 else
 begin
 print( 'not update track')
 end
END

------------------------------------------------------------------------------------------------------------------------------

CREATE  proc updateintake(@InstructorUserName varchar(15),@valueupdate varchar(50) ,@id1 int)
as
begin
   declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
 UPDATE [dbo].[Intake]  set  [Name]=@valueupdate  where [ID]=@id1
print( 'update Intake')
 end
 else
 begin
 print( 'not update Intake')
 end
 end
 ------------------------------------------------------------------------------------------------------------------------------
 CREATE  proc updatepranch(@InstructorUserName varchar(15),@valueupdate varchar(50) ,@id1 int)
as
begin
   declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
 UPDATE [dbo].[Branch]  set  [Name]=@valueupdate  where [ID]=@id1
print( 'update Branch')
 end
 else
 begin
 print( 'not update Branch')
 end
 end
 ------------------------------------------------------------------------------------------------------------------------------
 create proc addquetionrandom(@instructorid int, @courseid int,@numberofquestion int)
as
begin
 declare @maxid int
 set  @maxid=(select count(*) from [qp].[QuestionPool] )
WHILE @numberofquestion > 0
BEGIN
  declare @id int
  declare @idmsq int
  set @id =(SELECT CAST(FLOOR(RAND()*@maxid+1) AS int))
   if(@id!=0 and @id<=@maxid)
   BEGIN
   select *from [qp].[QuestionPool] where [ID]=@id
  set @numberofquestion=(select @numberofquestion-1);
   end
END
end

------------------------------------------------------------------------------------------------------------------------------
CREATE  proc updateInstructoraddress(@InstructorUserName varchar(15),@Address varchar(100),@id1 int)
as
begin
   declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
 UPDATE  [dbo].[Instructor] set [Address]=@Address where [ID]=@id1
print( 'update Instructor')
 end
 else
 begin
 print( 'not update Instructor')
 end
END

------------------------------------------------------------------------------------------------------------------------------

CREATE  proc updateInstructormobilphonand(@InstructorUserName varchar(15),@MobilePhone varchar(11),@id1 int)
as
begin
   declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
 UPDATE  [dbo].[Instructor] set [MobilePhone]=@MobilePhone where [ID]=@id1
print( 'update Instructor')
 end
 else
 begin
 print( 'not update Instructor')
 end
END

------------------------------------------------------------------------------------------------------------------------------
CREATE  proc updatestudentmobilphonand(@InstructorUserName varchar(15),@MobilePhone varchar(11) ,@id1 int)
as
begin
   declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
 UPDATE [std].[Student]  set [MobilePhone] = @MobilePhone where [ID]=@id1
print( 'update Student')
 end
 else
 begin
 print( 'not update Student')
 end
END

------------------------------------------------------------------------------------------------------------------------------

CREATE  proc updatestudentaddress(@InstructorUserName varchar(15),@Address varchar(100),@id1 int)
as
begin
   declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
 UPDATE [std].[Student]  set [Address]=@Address where [ID]=@id1
print( 'update Student')
 end
 else
 begin
 print( 'not update Student')
 end
END

------------------------------------------------------------------------------------------------
-------------------------------------------Barsoum Procedures-------------------------------------

-- (1)Show Exam
Create proc ShowExam(@examid int,@courseid int)
as
begin
  select q.[Question] from [qp].[QuestionPool] q,[dbo].[Exam] e
  where e.ID=q.ExamID and e.ID=@examid and q.CourseID=@courseid
end



------------------------------------------------------------------------------------------------------------------------------
-- (2) Students Answers

--insert True&Fale Strdent Answer
Create proc TF_StudentAnswer(@answer char(1) ,@stdid int)
as
begin
  insert into[std].[STF] values(@answer,@stdid);
end


------------------------------------------------------------------------------------------------------------------------------
--insert MCQ Strdent Answer
create proc MCQ_StudentAnswer(@answer varchar(15) ,@stdid int)
as
begin
  insert into [std].[SMCQ] values(@answer,@stdid);
end



------------------------------------------------------------------------------------------------------------------------------
--insert Text Strdent Answer
create proc Text_StudentAnswer(@answer varchar(500) ,@stdid int)
as
begin
  insert into [std].[SText] values(@answer,@stdid);
end


------------------------------------------------------------------------------------------------------------------------------
-- 3)Add Exam By Instuctor
create proc AddExam(@starttime datetime,@endtime datetime)
as
begin

  insert into [dbo].[Exam]([StartTime],[EndTime]) values( @starttime,@endtime);
end


--------------------------------------------------------------------------------------------------------------------------------

-- 3)Select Students By Instuctor that has his course
create proc SelectStudents(@stdid int)
as
begin
 select std.[ID],std.[Name],std.[Address],std.[Gender]  from  [dbo].[Teach] t,[dbo].[Instructor] inst,[dbo].[Course] crs,[std].[Student] std
 where t.CourseID=crs.Id and t.InstructorID=inst.ID and t.StudentId=std.ID and std.ID=@stdid;
end



------------------------------------------------------------------------------------------------------------------------------
--Deleting Instructor
Create proc DeleteInstructorByTrainingManager(@managerid int,@instructorid int)
as
begin

  declare @instructorAdmimID int
   set @instructorAdmimID =(select count([ManagerID]) from [dbo].[Manager] 
   where  [ManagerID]=@managerid);

   if(@instructorAdmimID !=0)
     Delete from [dbo].[Instructor] where [ID]=@instructorid
   
   else
      begin
	  declare @Message varchar(20)
	  set @Message='Sorry , Training Manger Can Delete Only';
	  end

end


------------------------------------------------------------------------------------------------------------------------------
--Deleting Course
Create proc DeleteCourseByTrainingManager(@managerid int,@courseid int)
as
begin

  declare @instructorAdmimID int
   set @instructorAdmimID =(select count([ManagerID]) from [dbo].[Manager] 
   where  [ManagerID]=@managerid);

   if(@instructorAdmimID !=0)
     Delete from [dbo].[Course]where [ID]=@courseid
   
   else
      begin
	  declare @Message varchar(20)
	  set @Message='Sorry , Training Manger Can Delete Only';
	  end

end


------------------------------------------------------------------------------------------------------------------------------
--Deleting Student
Create proc DeleteStudentByTrainingManager(@managerid int,@studentid int)
as
begin

  declare @instructorAdmimID int
   set @instructorAdmimID =(select count([ManagerID]) from [dbo].[Manager] 
   where  [ManagerID]=@managerid);

   if(@instructorAdmimID !=0)
     Delete from [std].[Student]where [ID]=@studentid
   
   else
      begin
	  declare @Message varchar(20)
	  set @Message='Sorry , Training Manger Can Delete Only';
	  end

end




------------------------------------------------------------------------------------------------------------------------------

--Deleting Track
Create proc DeleteTrackByTrainingManager(@managerid int,@trackid int)
as
begin

  declare @instructorAdmimID int
   set @instructorAdmimID =(select count([ManagerID]) from [dbo].[Manager] 
   where  [ManagerID]=@managerid);

   if(@instructorAdmimID !=0)
     Delete from[dbo].[Track] where [ID]=@trackid
   
   else
      begin
	  declare @Message varchar(20)
	  set @Message='Sorry , Training Manger Can Delete Only';
	  end

end




------------------------------------------------------------------------------------------------------------------------------
--Deleting Branch
Create proc DeleteBranchByTrainingManager(@managerid int,@branchid int)
as
begin

  declare @instructorAdmimID int
   set @instructorAdmimID =(select count([ManagerID]) from [dbo].[Manager] 
   where  [ManagerID]=@managerid);

   if(@instructorAdmimID !=0)
     Delete from[dbo].[Branch] where [ID]=@branchid
   
   else
      begin
	  declare @Message varchar(20)
	  set @Message='Sorry , Training Manger Can Delete Only';
	  end

end



------------------------------------------------------------------------------------------------------------------------------
--Deleting InTake
Create proc DeleteInTakeByTrainingManager(@managerid int,@intakeid int)
as
begin

  declare @instructorAdmimID int
   set @instructorAdmimID =(select count([ManagerID]) from [dbo].[Manager] 
   where  [ManagerID]=@managerid);

   if(@instructorAdmimID !=0)
     Delete from [dbo].[Intake] where [ID]=@intakeid
   
   else
      begin
	  declare @Message varchar(20)
	  set @Message='Sorry , Training Manger Can Delete Only';
	  end

end






------------------------------------------------------------------------------------------------
-------------------------------------------SALMA Procedures-------------------------------------

create proc ShowQuestionPool(@InstructorUserName varchar(15) , @CourseID int)
as
begin
declare @Iid int
declare @id int
set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)

set @Iid=
	(
	 select InstructorID from [dbo].[InstructorHasCourse]
	 where CourseID=@CourseID
	)

	if(@Iid = @Iid)
	begin
	select * from [qp].[QuestionPool] where [CourseID]=@CourseID
	end
	else
	begin
	     print('There was error')
	end
end

insert into [qp].[QuestionPool](Question,Mark,CourseID)values('scfasgveagvscxavscda',1,4)
insert into [qp].[TF] values('f',1)



----------------------------------------------------------------------------------------------------------------------------------------------------------
create proc AddQuestion(@InstructorUserName varchar(15),@CourseID int,@question varchar(100),@mark int,@examID int,@CorrectAnswer varchar(500))
as
begin
declare @Iid int
declare @id int
declare @QId int

set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)

set @Iid=
	(
	 select InstructorID from [dbo].[InstructorHasCourse]
	 where CourseID=@CourseID
	)
if(@Iid = @Iid)
begin
insert into [qp].[QuestionPool] values(@question,@examID,@mark,@CourseID)
set @QId =(select ID from [qp].[QuestionPool] where [Question]=@question)
insert into [qp].[Text] values(@CorrectAnswer,@QId)
end
else
begin
  print('Error')
end
end
insert into [dbo].[InstructorHasCourse] values(2,3)



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create proc AddCourse(@instructorusername varchar(15), @Name varchar(15),@Description varchar(100),@MinDegree int, @MaxDegree int)
as
begin
declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
    insert into [dbo].[Course] values ( @Name ,@Description ,@MinDegree , @MaxDegree)
 end
 else
 begin
  print('false')
 end
end



--------------------------------------------------------------------------------------------------------

create proc AddStudent(@instructorusername varchar(15), @Name varchar(50),@Gender char(1),@Address nvarchar(50), @Mobile char(11), 
@intakeID int, @BranchID int,@TrackID int, @Login int)
as
begin
declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
    insert into [std].[Student] values ( @Name ,@Gender ,@Address, @Mobile, 
@intakeID, @BranchID ,@TrackID, @Login)
 end
 else
 begin
  print('false')
 end
end



-------------------------------------------------------------------------------------------------------------------
create proc AddBranch(@instructorusername varchar(15), @Name nvarchar(50))
as
begin
declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
    insert into [dbo].[Branch] values (@Name)
 end
 else
 begin
  print('false')
 end
end


--------------------------------------------------------------------------------------------------------------------------
create proc AddTrack(@instructorusername varchar(15), @Name nvarchar(50))
as
begin
declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
    insert into [dbo].[Track] values (@Name)
 end
 else
 begin
  print('false')
 end
end



----------------------------------------------------------------------------------------------------------------------

create proc AddIntake(@instructorusername varchar(15), @Name nvarchar(50))
as
begin
declare @id int
declare @managerid int
  set @id =
           (select ID from [dbo].[Instructor] where [Name]=@InstructorUserName)
 set  @managerid=(select [InstructorID] from [dbo].[Manager] where [InstructorID]=@id)
 if(@id=@managerid)
 begin
    insert into [dbo].[Intake] values (@Name)
 end
 else
 begin
  print('false')
 end
end




--------------Views-------------


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------Barsoum Views-----------------------------------------------------
go
--Show Student Data
create View ShowStudent
as
(
select*from  [std].[Student]
)
go
-------------------------------------------------

--Show ShowStudentExam Data
create View ShowStudentExam
as
(
select*from  [std].[StudentExam]
)
go
-------------------------------------------------

--Show ShowIntake Data
create View ShowIntake 
as
(
select*from  [dbo].[Intake]
)
go
-------------------------------------------------


--Show ShowTrack Data
create View ShowTrack
as
(
select*from  [dbo].[Track]

)
go
---------------------------------------------------

--Show ShowBranch Data
create View ShowBranch
as
(
select*from [dbo].[Branch]

)
go
----------------------------------------------------



------------------------------------------------------------------------------------------------------------------
--------------------------------------------------Nermeen Views-----------------------------------------------------
create view allcourses_info
as
(
 select 
   [Name],
   [Description],
   [MinDegree],
   [MaxDegree]
 from [dbo].[Course]
)

------------------------------------------------------
create view allQuestion_info
as
(
 select 
   [Question],
   [Mark],
   [Name]
 from [qp].[QuestionPool],[dbo].[Course]
 where [qp].[QuestionPool].CourseID=[dbo].[Course].Id
)

------------------------------------------------------------

create view getallManager
AS
(
select [Name] from [dbo].[Instructor],[dbo].[Manager]
where [dbo].[Instructor].ID=[dbo].[Manager].InstructorID
)
-----------------------------------------------------------------

create view getMCQquestionandanswer
as
(
 select [Question],[CorrectAnswer]
 from [qp].[QuestionPool],[qp].[MCQ]
 where [qp].[QuestionPool].ID=[qp].[MCQ].QuestionID
)

-------------------------------------------------------------------





---------------Functions-------------------




-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Salma Functions-------------------------------------------------

CREATE FUNCTION QuestionAndAnswer
(@id int)
RETURNS table
AS
	RETURN 
	(
		SELECT qp.Question, qt.CorrectAnswer
		FROM [qp].[QuestionPool] qp INNER JOIN [qp].[Text] qt
		ON qp.ID = qt.QuestionID
		WHERE qp.ID = @id
	)


-----------------------------------------------------------------------------------------------
CREATE FUNCTION StudentAnswer
(@id int)
RETURNS table
AS
	RETURN 
	(
		SELECT qp.Question, st.Answer as StudentAnswer
		FROM [qp].[QuestionPool] qp INNER JOIN [std].[SText] st 
		ON qp.ID = st.ID
		WHERE st.StudentID = @id
	)

---------------------------------------------------------------------------------------------------------

CREATE FUNCTION CompareStudentAnswer
(@id int)
RETURNS table
AS
	RETURN 
	(
		SELECT qp.CorrectAnswer, st.Answer as StudentAnswer
		FROM [qp].[Text] qp INNER JOIN [std].[SText] st 
		ON qp.QuestionID = st.ID
		WHERE st.StudentID = @id
	)


-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------Nermeen Functions----------------------------------------------

create function getManager(@id int)
returns table
as 
return
(
    select [Name] from [dbo].[Instructor]
    where [dbo].[Instructor].ID=@id
)


-----------------------------------------------------------
create function getteachcourses(@id int)
returns table
as 
return
(
    select [dbo].[Course].[Name] from [dbo].[Course],[dbo].[InstructorHasCourse]
    where [dbo].[InstructorHasCourse].InstructorID=@id and [dbo].[InstructorHasCourse].CourseID=[dbo].[Course].Id
)




------------Trigger--------
Create TRIGGER UdateQuestion
ON [qp].[QuestionPool]
AFTER UPDATE
AS
begin
IF UPDATE (Question)
	begin
	declare @id	int 
		UPDATE [qp].[QuestionPool]
		set @id =(select ID from inserted)
		WHERE ID = @id
	end
end

-------------------------------------------

Create TRIGGER UpdateCourse
ON [qp].[QuestionPool]
AFTER UPDATE
AS
begin
IF UPDATE (CourseID)
	begin
	declare @id	int 
		UPDATE [qp].[QuestionPool]
		set @id =(select ID from inserted)
		WHERE ID = @id
	end
end
------------------------------------------------
