--Provider Table
--Objective: Identify cost trends per provider over time, potentially highlighting providers driving higher costs.
SELECT 
    provider_id,
    provider_name,
    EXTRACT(YEAR FROM service_date) AS year,
    SUM(total_cost) AS total_cost,
    COUNT(DISTINCT patient_id) AS patient_count,
    AVG(total_cost) AS avg_cost_per_patient
FROM 
    Provider
WHERE 
    service_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY 
    provider_id, provider_name, EXTRACT(YEAR FROM service_date)
ORDER BY 
    total_cost DESC;

--Pharmacy Table
--Objective: Explore prescription costs and frequency to see if any particular drugs or types are significant cost drivers.
SELECT 
    drug_id,
    drug_name,
    EXTRACT(YEAR FROM prescription_date) AS year,
    SUM(cost) AS total_cost,
    COUNT(DISTINCT patient_id) AS unique_patient_count,
    COUNT(prescription_id) AS prescription_count
FROM 
    Pharmacy
WHERE 
    prescription_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY 
    drug_id, drug_name, EXTRACT(YEAR FROM prescription_date)
ORDER BY 
    total_cost DESC;

--MedicalService Table
--Objective: Identify types of medical services that might be driving up costs, aggregated by year.
SELECT 
    service_type,
    EXTRACT(YEAR FROM service_date) AS year,
    SUM(cost) AS total_service_cost,
    COUNT(DISTINCT patient_id) AS patient_count,
    AVG(cost) AS avg_cost_per_service
FROM 
    MedicalService
WHERE 
    service_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY 
    service_type, EXTRACT(YEAR FROM service_date)
ORDER BY 
    total_service_cost DESC;

--Medical Table
--Objective: Provide an overview of medical claims by diagnostic categories, which can highlight cost drivers by health condition.
SELECT 
    diagnosis_code,
    diagnosis_description,
    EXTRACT(YEAR FROM claim_date) AS year,
    SUM(claim_amount) AS total_claim_amount,
    COUNT(DISTINCT patient_id) AS patient_count,
    AVG(claim_amount) AS avg_claim_cost
FROM 
    Medical
WHERE 
    claim_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY 
    diagnosis_code, diagnosis_description, EXTRACT(YEAR FROM claim_date)
ORDER BY 
    total_claim_amount DESC;

--Eligibility Table
--Objective: Provide a summary of eligibility data, particularly to see if there’s a correlation between eligibility type and cost.
SELECT 
    eligibility_type,
    COUNT(DISTINCT patient_id) AS patient_count,
    EXTRACT(YEAR FROM eligibility_start_date) AS year,
    COUNT(claim_id) AS claim_count,
    SUM(total_claim_amount) AS total_claim_cost,
    AVG(total_claim_amount) AS avg_claim_cost
FROM 
    Eligibility
WHERE 
    eligibility_start_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY 
    eligibility_type, EXTRACT(YEAR FROM eligibility_start_date)
ORDER BY 
    total_claim_cost DESC;
