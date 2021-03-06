use std::fs::File;
use std::io::{BufRead, BufReader};

#[derive(Debug, PartialEq)]
struct PasswordEntry {
    character: char,
    first_check_index: usize,
    second_check_index: usize,
    password: String,
}

impl PasswordEntry {
    fn is_valid(&self) -> bool {
        let mut chars = self.password.chars();
        let mut occurrences_in_positions = 0;
        if chars.nth(self.first_check_index - 1).unwrap() == self.character {
            occurrences_in_positions += 1;
        }
        if chars
            .nth(self.second_check_index - self.first_check_index - 1)
            .unwrap()
            == self.character
        {
            occurrences_in_positions += 1;
        }

        occurrences_in_positions == 1
    }

    fn parse(input: String) -> Result<PasswordEntry, String> {
        let mut password_rule_split = input.split(": ");
        let mut rule_parts = match password_rule_split.next() {
            Some(s) => s.splitn(4, |c| c == ' ' || c == '-'),
            None => return Err(String::from("Invalid input string")),
        };

        let first_check_index_str = match rule_parts.next() {
            Some(s) => s,
            None => return Err(String::from("Invalid input string")),
        };
        let second_check_index_str = match rule_parts.next() {
            Some(s) => s,
            None => return Err(String::from("Invalid input string")),
        };
        let character_str = match rule_parts.next() {
            Some(s) => s,
            None => return Err(String::from("Invalid input string")),
        };
        let password = match password_rule_split.next() {
            Some(s) => s,
            None => return Err(String::from("Invalid input string")),
        };

        let first_check_index: usize = match first_check_index_str.parse() {
            Ok(val) => val,
            Err(_) => return Err(String::from("Invalid input string")),
        };
        let second_check_index: usize = match second_check_index_str.parse() {
            Ok(val) => val,
            Err(_) => return Err(String::from("Invalid input string")),
        };

        if character_str.len() != 1 {
            return Err(String::from("Invalid input string"));
        }
        let character: char = character_str.chars().nth(0).unwrap();

        Ok(PasswordEntry {
            character,
            first_check_index,
            second_check_index,
            password: String::from(password),
        })
    }
}

fn main() {
    let filename = "input.txt";
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);

    let mut valid_passwords = 0;

    // Read the file line by line using the lines() iterator from std::io::BufRead.
    for line in reader.lines() {
        let line = line.unwrap();

        let password_entry = PasswordEntry::parse(line).unwrap();

        if password_entry.is_valid() {
            valid_passwords += 1;
        }
    }

    println!("Valid passwords: {}", valid_passwords);
}

#[cfg(test)]
mod tests {
    use crate::PasswordEntry;

    #[test]
    fn parse_success() {
        let entry = PasswordEntry::parse(String::from("1-2 a: aab")).unwrap();
        let expected = PasswordEntry {
            character: 'a',
            first_check_index: 1,
            second_check_index: 2,
            password: String::from("aab"),
        };
        assert_eq!(expected, entry);
    }

    #[test]
    fn parse_failure() {
        let entry = PasswordEntry::parse(String::from("1-3: abb aab"));
        let expected = Err(String::from("Invalid input string"));
        assert_eq!(expected, entry);
    }

    #[test]
    fn valid() {
        let entry = PasswordEntry::parse(String::from("1-3 a: aab")).unwrap();
        assert_eq!(true, entry.is_valid());
    }

    #[test]
    fn invalid_upper_bound() {
        let entry = PasswordEntry::parse(String::from("1-2 a: aab")).unwrap();
        assert_eq!(false, entry.is_valid());
    }

    #[test]
    fn invalid() {
        let entry = PasswordEntry::parse(String::from("1-2 a: aab")).unwrap();
        assert_eq!(false, entry.is_valid());
    }

    #[test]
    fn test_case_2() {
        let entry = PasswordEntry::parse(String::from("1-3 b: cdefg")).unwrap();
        assert_eq!(false, entry.is_valid());
    }

    #[test]
    fn test_case_3() {
        let entry = PasswordEntry::parse(String::from("2-9 c: ccccccccc")).unwrap();
        assert_eq!(false, entry.is_valid());
    }
}
