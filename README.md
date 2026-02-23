# Robot Framework Python Automation Template

This is a clean template for a Robot Framework project with Python extensions.

## Structure

- **tests/**: Directory for test suites (organized by module).
- **resources/**: Directory for Robot keywords and locators.
- **python_lib/**: Directory for custom Python libraries.
- **config/**: Directory for configuration files.
- **results/**: Directory for test results.

## Usage

1. **Install Dependencies**:

   ```bash
   pip install robotframework robotframework-seleniumlibrary
   ```

2. **Implement Logic**:
   - Add locators to `resources/locators.robot`.
   - Add keywords to `resources/keywords.robot`.
   - Implement Python logic in `python_lib/`.

3. **Run Tests**:
    Run All tests
   ```bash
   robot --outputdir results tests/
   ```

   Run Specific Test File
```bash
robot --outputdir results tests/profile/[TC_FileName].robot
```
   
### Resources (`resources/`)
- **keywords.robot**: Contains all reusable keywords including:
  - Launch Application
  - Navigate To Profile Page
  - Validate Update Profile
  - Update Profile Names
  - Verify Updated User Name

- **locators.robot**: Contains all locators for the application elements.

## Test Results

After running tests, reports are generated in the `results/` directory:
- `report.html` - Test execution report
- `log.html` - Detailed test execution log
- `output.xml` - Machine-readable test output


# Current Test Coverage

### Profile Tests (`tests/profile/`)

| Test Case ID | Test Case Name | Description | Tags |
|---|---|---|---|
| TC_001 | TC_Verify_User_Profile_Update_name | Verifies a logged-in user can update their First and Last name on the profile page. Validates no error messages appear and the updated name is reflected on the profile page and in the header dropdown. Also resets the name back to original values after verification. | `profile` |
| TC_002 | TC_Verify_Update_Profile_Picture_Functionality | Verifies a logged-in user can upload a valid profile picture. Validates the updated picture is reflected on the profile page and in the header avatar both on the profile page and after navigating back to the home page. | `profile` |

---

### Required Environment Variables

Before running the tests, ensure the following environment variables are set:

| Variable | Description |
|---|---|
| `MORENT_BASE_URL` | Base URL of the application |
| `MORENT_USER_EMAIL` | Test account email |
| `MORENT_USER_PASSWORD` | Test account password |

### Test Data

| File | Location | Used In |
|---|---|---|
| `Valid_update_profile_picture.jpg` | `resources/Uploads/` | `TC_Verify_Update_Profile_Picture_Functionality` |