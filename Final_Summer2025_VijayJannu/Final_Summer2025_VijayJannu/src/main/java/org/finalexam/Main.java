package org.finalexam;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

import java.sql.*;
import java.time.LocalDate;

public class Main extends Application {

    Connection conn;

    @Override
    public void start(Stage stage) {

        connectToDB();

        GridPane grid = new GridPane();
        grid.setPadding(new Insets(20));
        grid.setVgap(15);
        grid.setHgap(15);
        grid.setAlignment(Pos.CENTER);

        ImageView img = new ImageView(new Image("v_logo.jpg"));
        img.setFitHeight(100);
        img.setFitWidth(100);

        Label title = new Label("Employment Application Form");
        title.setStyle("-fx-font-size: 20px; -fx-font-weight: bold;");

        Label lblName = new Label("Full Name:");
        TextField txtName = new TextField();

        Label lblContact = new Label("Contact Number:");
        TextField txtContact = new TextField();

        Label lblEdu = new Label("Highest Education:");
        ComboBox<String> cmbEdu = new ComboBox<>();
        cmbEdu.getItems().addAll("Masters", "Bachelors", "College Diploma");

        Label lblDate = new Label("Date of Birth:");
        DatePicker dpDOB = new DatePicker();

        Label lblSalary = new Label("Expected Salary:");
        TextField txtSalary = new TextField();

        Button btnSubmit = new Button("Submit");
        btnSubmit.setStyle("-fx-background-color: #1e90ff; -fx-text-fill: white;");

        // Add nodes to Grid
        grid.add(img, 0, 0, 2, 1);
        grid.add(title, 0, 1, 2, 1);

        grid.add(lblName, 0, 2);
        grid.add(txtName, 1, 2);

        grid.add(lblContact, 0, 3);
        grid.add(txtContact, 1, 3);

        grid.add(lblEdu, 0, 4);
        grid.add(cmbEdu, 1, 4);

        grid.add(lblDate, 0, 5);
        grid.add(dpDOB, 1, 5);

        grid.add(lblSalary, 0, 6);
        grid.add(txtSalary, 1, 6);

        grid.add(btnSubmit, 1, 7);

        btnSubmit.setOnAction(e -> {

            // VALIDATIONS
            if (!txtName.getText().matches("[a-zA-Z ]{1,50}")) {
                showAlert("Full name must be alphabet only (max 50 chars).");
                return;
            }

            if (!txtContact.getText().matches("\\d{10}")) {
                showAlert("Contact number must be exactly 10 digits.");
                return;
            }

            if (cmbEdu.getValue() == null) {
                showAlert("Select your education.");
                return;
            }

            LocalDate dob = dpDOB.getValue();
            if (dob == null) {
                showAlert("Select a valid date.");
                return;
            }

            if (!txtSalary.getText().matches("\\d{1,8}\\.\\d{2}")) {
                showAlert("Salary format: 8 digits + .00 Example: 12345678.50");
                return;
            }

            insertToDB(txtName.getText(), txtContact.getText(), cmbEdu.getValue(),
                    dob.toString(), txtSalary.getText());
        });

        Scene scene = new Scene(grid, 500, 600);
        stage.setScene(scene);
        stage.setTitle("Final Exam - JavaFX");
        stage.show();
    }

    void connectToDB() {
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/final_exam", "root", "root2025");
            System.out.println("Connected Successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    void insertToDB(String name, String contact, String edu, String dob, String salary) {
        try {
            String sql = "INSERT INTO ApplicantTable (fullname, contact, education, dob, salary) VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pst.setString(1, name);
            pst.setString(2, contact);
            pst.setString(3, edu);
            pst.setString(4, dob);
            pst.setString(5, salary);

            pst.executeUpdate();

            ResultSet rs = pst.getGeneratedKeys();
            int appId = 0;
            if (rs.next()) appId = rs.getInt(1);

            // Insert into Employment Table
            String sql2 = "INSERT INTO EmploymentTable (applicant_id, status) VALUES (?,?)";
            PreparedStatement pst2 = conn.prepareStatement(sql2);
            pst2.setInt(1, appId);
            pst2.setString(2, "Pending");
            pst2.executeUpdate();

            // Insert into EmploymentApplication table
            String sql3 = "INSERT INTO EmploymentApplication (applicant_id, applied_on) VALUES (?,CURDATE())";
            PreparedStatement pst3 = conn.prepareStatement(sql3);
            pst3.setInt(1, appId);
            pst3.executeUpdate();

            showAlert("Application Submitted Successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    void showAlert(String msg) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setHeaderText(null);
        alert.setContentText(msg);
        alert.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
