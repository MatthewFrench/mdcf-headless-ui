library PatientBar;
//import 'dart:html';

class PatientBar {
  //DivElement mainDiv;
  Map patientData;
  //LabelElement name, birth, gender, allergies, notes;

  PatientBar() {
    /*
    mainDiv = new DivElement();
    mainDiv.id = "PatientBar";
    mainDiv.className = "mainDiv";

    var label = new LabelElement();
    label.text = "Patient Information";
    label.id = "PatientBar";
    label.className = "title";
    mainDiv.append(label);

    var patientInfoContainer = new DivElement();
    patientInfoContainer.id = "PatientBar";
    patientInfoContainer.className = "patientInfo";
    mainDiv.append(patientInfoContainer);

    label = new LabelElement();
    label.text = "Name: ";
    label.id = "PatientBar";
    label.className = "nameLabel";

    name = new LabelElement();
    name.text = "";
    name.id = "PatientBar";
    name.className = "name";

    var container = new DivElement();
    container.id = "PatientBar";
    container.className = "infoContainer";
    container.append(label);
    container.append(name);
    patientInfoContainer.append(container);

    label = new LabelElement();
    label.text = "DOB: ";
    label.id = "PatientBar";
    label.className = "birthLabel";

    birth = new LabelElement();
    birth.text = "";
    birth.id = "PatientBar";
    birth.className = "birth";

    container = new DivElement();
    container.id = "PatientBar";
    container.className = "infoContainer";
    container.append(label);
    container.append(birth);
    patientInfoContainer.append(container);

    label = new LabelElement();
    label.text = "Gender: ";
    label.id = "PatientBar";
    label.className = "genderLabel";

    gender = new LabelElement();
    gender.text = "";
    gender.id = "PatientBar";
    gender.className = "gender";

    container = new DivElement();
    container.id = "PatientBar";
    container.className = "infoContainer";
    container.append(label);
    container.append(gender);
    patientInfoContainer.append(container);

    label = new LabelElement();
    label.text = "Allergies: ";
    label.id = "PatientBar";
    label.className = "allergiesLabel";

    allergies = new LabelElement();
    allergies.text = "";
    allergies.id = "PatientBar";
    allergies.className = "allergies";

    container = new DivElement();
    container.id = "PatientBar";
    container.className = "infoContainer";
    container.append(label);
    container.append(allergies);
    patientInfoContainer.append(container);

    label = new LabelElement();
    label.text = "Notes: ";
    label.id = "PatientBar";
    label.className = "notesLabel";

    notes = new LabelElement();
    notes.text = "";
    notes.id = "PatientBar";
    notes.className = "notes";

    container = new DivElement();
    container.id = "PatientBar";
    container.className = "infoContainer";
    container.append(label);
    container.append(notes);
    patientInfoContainer.append(container);

    var button = new ButtonElement();
    button.text = "More Information";
    button.id = "PatientBar";
    button.className = "moreInfo";
    mainDiv.append(button);
*/
    patientData = {};
    setPatientData(patientData);
  }

  void setPatientData(Map data) {
    patientData = data;
/*
    name.text = patientData['name'];
    birth.text = patientData['birth'];
    gender.text = patientData['gender'];
    allergies.text = patientData['allergies'];
    notes.text = patientData['notes'];
    */
  }

  //DivElement getDiv() {
  //  return mainDiv;
  //}
}