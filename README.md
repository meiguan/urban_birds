# Sounds of Spring
Github Repo: urban_birds

NYU CUSP Capstone group: Urban Dynamics of Bird Migration (Cornell Lab of Ornithology)

> [Our Paper](https://www.authorea.com/471763/t6Ypp1w_mqa8DnfV2nMeYw "Sounds of Spring: Urban Noise and Bird Migration in Washington Square Park")

## Folder Structure:
1. *staging* - this is for the rawest of data, mostly to bring data into the environment
2. *explore* - this is for data exploration, generate descriptives
3. *clean* - this is for scripts/ notebooks related to data cleaning/ wrangling
4. *model* - this is for scripts/ notebooks related to modeling
5. *envir* - this folder will not be committed but it should be created in your repo to manage environmental variables and secrets

## Data Sets
1. *Acoustic Data - SONYC*
    
    * Sound Pressure Levels (SPL)
    * YAMNet Classification
    
2. *Weather Surveillance Data - NEXRAD*
3. *Citizen Science Data - eBird*
4. *Weather Data* 

In the data warehousing directory, datasets were organized by their source and analysis readiness -- raw files (originals pre-processing) and clean files (post processing). Data file names also relate to which folder the code is stored. For example, if this is a dataset from a jupyter notebook in the clean folder, then the dataset file name should be 'clean_xxx_data.csv'

## Team Roles
For this project, each member of the team will be engaging in all aspects of this capstone project from data wrangling to modeling to report writing. Since different team members have different strengths and interests, our team has identified leads in certain areas as listed below:

- Project Manager - Mei
- Lead on Weather Surveillance Data (NEXRAD) - Mei
- Leads on Acoustic Data (SONYC)

    - Temporal measures of sound pressure levels (SPL) from SONYC Sensors - Max
    - Classification outputs from YAMNet for birds - Xin

- Lead on Citizen Science Data (eBird) - Martha
- Data Modeling - Mei & Xin
- Website Development - Martha
- Bird Content Knowledge - Max


