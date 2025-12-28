# Job Queue Parameters
<br>The extension adds parameters to job queue entry. 
<br>It extends the standard Parameter String solution with more user friendly configuration.

## Job Queue Entry
After creating a job queue entry with the object that have defined parameters, the parameters are displayd on the job queue entry card.
<br>The parameters are created with default values that can be changed for each job queue entry.
<br>
![JobQueueEntryParams](img\JobQueueEntryParams.png)

## Job Queue Entry Parameter Templates
Job Queue Entry Parameter Templates contains all parameters used by any object. The records should be created in Install codeunit by the extension that provides a codeunit/report that uses the job queue entry parameters. The default values and description can be changed from here.
<br>
![JobQueueEntryParameterTempl](img\JobQueueEntryParameterTempl.png)
<br>
![JobQueueEntryParameterTemplCard](img\JobQueueEntryParameterTemplCard.png)

## Job Queue Entry Parameters
Job Queue Entry Parameters contains all parameters used by any job queue entry. It is possible to modify its values from the job queue entry card or from here.
<br>
![JobQueueEntryParameter](img\JobQueueEntryParameter.png)
<br>
![JobQueueEntryParameterCard](img\JobQueueEntryParameterCard.png)

## demo-ext
The demo-ext contains a sample extension that uses the job queue entry parameters.
